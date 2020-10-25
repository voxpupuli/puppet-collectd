# rabbitmq plugin
# https://pypi.python.org/pypi/collectd-rabbitmq
#
# == Class collectd::plugin::rabbitmq
#
#  Configures rabbitmq metrics collection. Optionally installs the plugin
#  Note, it is up to you to support package installation and sources
#
# === Parameters:
# [*ensure*]
#   String
#   Passed to package and collectd::plugin resources ( both )
#   Default: present
#
# [*interval*]
#   Integer
#   Interval setting for the plugin
#   Default: undef
#
# [*manage_package*]
#   Boolean
#   Toggles installation of plugin. Please reference https://collectd-rabbitmq.readthedocs.org/en/latest/installation.html
#   Default: undef
#
# [*package_provider*]
#   String
#   Passed to package resource
#   Default: pip
#
# [*config*]
#   Hash
#   Contains key/value passed to the python module to configure the plugin
#   Note we have had issues with the Realm value and quoting, seems to be an issue with quoting. Multi-word values need to be wrapped in '"xxxx"'
#   Default: {
#    'Username' => 'guest',
#    'Password' => 'guest_pass',
#    'Scheme'   => 'http',
#    'Port'     => '15672',
#    'Host'     => $facts['fqdn'],
#    'Realm'    => '"RabbitMQ Management"',
#   }
#
class collectd::plugin::rabbitmq (
  # lint:ignore:parameter_order
  Hash $config      = {
    'Username' => 'guest',
    'Password' => 'guest',
    'Scheme'   => 'http',
    'Port'     => '15672',
    'Host'     => $facts['networking']['fqdn'],
    'Realm'    => '"RabbitMQ Management"',
  },
  # lint:endignore
  String $ensure    = 'present',
  $interval         = undef,
  $manage_package   = undef,
  $package_name     = 'collectd-rabbitmq',
  $package_provider = 'pip',
  $provider_proxy   = undef,
  $custom_types_db  = undef,
) {
  include collectd

  if $facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'],'8') >= 0 {
    fail('https://pypi.org/project/collectd-rabbitmq/ does not support Python 3')
  }

  case $facts['os']['family'] {
    'RedHat': {
      $_custom_types_db = '/usr/share/collectd-rabbitmq/types.db.custom'
    }
    default: {
      $_custom_types_db = '/usr/local/share/collectd-rabbitmq/types.db.custom'
    }
  }

  $_real_custom_types_db = pick($custom_types_db, $_custom_types_db)
  $_manage_package = pick($manage_package, $collectd::manage_package)

  if ($_manage_package) {
    if (!defined(Package['python-pip'])) {
      package { 'python-pip': ensure => 'present', }

      Package[$package_name] {
        require => Package['python-pip'],
      }

      if $facts['os']['family'] == 'RedHat' {
        # Epel is installed in install.pp if manage_repo is true
        # python-pip doesn't exist in base for RedHat. Need epel installed first
        if (defined(Class['epel'])) {
          Package['python-pip'] {
            require => Class['epel'],
          }
        }
      }
    }
  }

  if ($_manage_package) and ($provider_proxy) {
    $install_options = [{ '--proxy' => $provider_proxy }]
  } else {
    $install_options = undef
  }

  package { $package_name:
    ensure          => $ensure,
    provider        => $package_provider,
    install_options => $install_options,
  }

  file { 'rabbitmq.load':
    ensure  => $ensure,
    path    => "${collectd::plugin_conf_dir}/10-rabbitmq.conf",
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => template('collectd/plugin/rabbitmq.conf.erb'),
    notify  => Service[$collectd::service_name],
  }

  collectd::plugin::python::module { 'collectd_rabbitmq.collectd_plugin':
    ensure => $ensure,
    config => [$config],
  }
}
