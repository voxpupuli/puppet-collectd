# https://collectd.org/wiki/index.php/Plugin:memcached
class collectd::plugin::memcached (
  $ensure = present,
  $host   = '127.0.0.1',
  $port   = '11211',
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'memcached.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/memcached.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/memcached.conf.erb'),
    notify    => Service['collectd']
  }
}
