# See http://collectd.org/documentation/manpages/collectd-perl.5.shtml
class collectd::plugin::perl (
  $ensure = undef
  $manage_package   = undef,
  $interval         = undef,
  $order            = 20
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  $conf_dir = $collectd::plugin_conf_dir

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-perl':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'perl':
    ensure   => $ensure_real,
    globals  => true,
    interval => $interval,
    order    => $order,
    content  => template('collectd/plugin/perl.conf.erb'),
  }

  file { "${conf_dir}/perl":
    ensure => directory,
    mode   => '0755',
    owner  => $collectd::root_user,
    group  => $collectd::root_group,
  }
}

