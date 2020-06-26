# See http://collectd.org/documentation/manpages/collectd-perl.5.shtml
class collectd::plugin::perl (
  $ensure           = 'present',
  $manage_package   = undef,
  $interval         = undef,
  $order            = 20
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  $conf_dir = $collectd::plugin_conf_dir

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-perl':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'perl':
    ensure   => $ensure,
    globals  => true,
    interval => $interval,
    order    => $order,
    content  => template('collectd/plugin/perl.conf.erb'),
  }

  file { "${conf_dir}/perl":
    ensure => directory,
    mode   => $collectd::plugin_conf_dir_mode,
    owner  => $collectd::config_owner,
    group  => $collectd::config_group,
  }
}
