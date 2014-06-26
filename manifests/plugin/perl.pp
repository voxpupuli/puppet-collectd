# See http://collectd.org/documentation/manpages/collectd-perl.5.shtml
class collectd::plugin::perl ()
{
  include collectd::params
  $conf_dir = $collectd::params::plugin_conf_dir
  $filename = "${conf_dir}/perl.conf"
  file { $filename:
    mode    => '0644',
    owner   => $collectd::params::root_user,
    group   => $collectd::params::root_group,
    notify  => Service['collectd'],
    content => template('collectd/plugin/perl.conf.erb'),
  }
  file { "${conf_dir}/perl":
    ensure => directory,
    mode   => '0755',
    owner  => $collectd::params::root_user,
    group  => $collectd::params::root_group,
  }
}

