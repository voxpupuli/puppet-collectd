# https://collectd.org/wiki/index.php/Plugin:memcached
class collectd::plugin::memcached (
  $ensure = undef
  $host     = '127.0.0.1',
  $interval = undef,
  $port     = 11211,
) {

  include ::collectd

  collectd::plugin { 'memcached':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/memcached.conf.erb'),
    interval => $interval,
  }
}
