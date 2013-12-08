# A define to make a generic network output for collectd
class collectd::plugin::write_network (
  $ensure  = 'present',
  $servers = { 'localhost'  =>  { 'serverport' => '25826' } },
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_hash($servers)

  file { 'write_network.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/write_network.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/write_network.conf.erb'),
    notify    => Service['collectd'],
  }
}
