# A define to make a generic network output for collectd
class collectd::plugin::write_network (
  $servers = { 'localhost'  =>  { 'serverport' => '25826' } },
  $ensure  = 'present',
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'write_network.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/write_network.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/write_network.conf.erb'),
    notify    => Service['collectd'],
  }
}
