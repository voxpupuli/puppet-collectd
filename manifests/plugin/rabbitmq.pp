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
#   Default: {
#    'Username' => '"guest"',
#    'Password' => '"guest_pass"',
#    'Scheme'   => '"http"',
#    'Port'     => '"15672"',
#    'Host'     => "\"${::fqdn}\"",
#    'Realm'    => '"RabbitMQ Management"',
#   }
#
class collectd::plugin::rabbitmq (
  $config           = {
    'Username' => '"guest"',
    'Password' => '"guest"',
    'Scheme'   => '"http"',
    'Port'     => '"15672"',
    'Host'     => "\"${::fqdn}\"",
    'Realm'    => '"RabbitMQ Management"',
  },
  $ensure           = 'present',
  $interval         = undef,
  $manage_package   = undef,
  $package_name     = 'collectd-rabbitmq',
  $package_provider = 'pip',
) {
  include ::collectd

  validate_string($ensure)
  validate_hash($config)

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $_manage_package {
    package { $package_name:
      ensure   => $ensure,
      provider => $package_provider,
    }
  }
  collectd::typesdb { '/usr/share/collect-rabbitmq/types.db.custom': }
  collectd::plugin::python::module { 'collectd_rabbitmq.collectd_plugin':
    ensure => $ensure,
    config => $config,
  }
}
