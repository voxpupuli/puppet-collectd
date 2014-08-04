# See http://collectd.org/documentation/manpages/collectd-perl.5.shtml
class collectd::plugin::perl (
  $ensure = present,
  $order  = 20
)
{
  include collectd::params
  $conf_dir = $collectd::params::plugin_conf_dir

  collectd::plugin { 'perl':
    ensure  => $ensure,
    order   => $order,
    content => template('collectd/plugin/perl.conf.erb')
  }

  file { "${conf_dir}/perl":
    ensure => directory,
    mode   => '0755',
    owner  => $collectd::params::root_user,
    group  => $collectd::params::root_group,
  }
}

