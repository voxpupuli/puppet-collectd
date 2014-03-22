# https://collectd.org/wiki/index.php/Plugin:memcached
class collectd::plugin::memcached (
  $ensure = present,
  $host   = '127.0.0.1',
  $port   = 11211,
) {
  collectd::plugin {'memcached':
    ensure  => $ensure,
    content => template('collectd/plugin/memcached.conf.erb'),
  }
}
