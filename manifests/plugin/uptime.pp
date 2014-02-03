# https://collectd.org/wiki/index.php/Plugin:Uptime
class collectd::plugin::uptime (
  $ensure           = present,
) {

  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'uptime.conf':
    ensure    => $collectd::plugin::uptime::ensure,
    path      => "${conf_dir}/uptime.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/uptime.conf.erb'),
    notify    => Service['collectd'],
  }

}
