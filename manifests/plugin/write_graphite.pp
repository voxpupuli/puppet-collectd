# https://collectd.org/wiki/index.php/Graphite
class collectd::plugin::write_graphite (
  $ensure       = present,
  $graphitehost = 'localhost',
  $graphiteport = 2003,
  $storerates   = false,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_bool($storerates)

  file { 'write_graphite.conf':
    ensure    => $collectd::plugin::write_graphite::ensure,
    path      => "${conf_dir}/write_graphite.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/write_graphite.conf.erb'),
    notify    => Service['collectd'],
  }
}
