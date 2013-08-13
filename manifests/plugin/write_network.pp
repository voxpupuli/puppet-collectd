# A define to make a generic network output for collectd
define collectd::plugin::write_network (
  $serverhost = 'localhost',
  $serverport = '25826',
  $ensure     = 'present',
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { "write_network_${name}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/write_network_${name}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/write_network.conf.erb'),
    notify    => Service['collectd'],
  }
}
