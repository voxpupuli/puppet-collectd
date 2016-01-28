# See http://collectd.org/documentation/manpages/collectd-perl.5.shtml
class collectd::plugin::perl (
  $ensure           = present,
  $manage_package   = $collectd::manage_package,
  $interval         = undef,
  $order            = 20
)
{
  include ::collectd::params
  $conf_dir = $collectd::params::plugin_conf_dir

  if $::osfamily == 'Redhat' {
    if $manage_package {
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
    mode   => '0755',
    owner  => $collectd::params::root_user,
    group  => $collectd::params::root_group,
  }
}

