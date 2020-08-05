# https://collectd.org/wiki/index.php/Plugin:memcached
class collectd::plugin::memcached (
  $ensure         = 'present',
  Hash $instances = {
    'default' => {
      'host'    => 'localhost',
      'address' => '127.0.0.1',
      'port'    => 11211,
    },
  },
  $interval       = undef,
) {
  include collectd

  collectd::plugin { 'memcached':
    ensure   => $ensure,
    content  => template('collectd/plugin/memcached.conf.erb'),
    interval => $interval,
  }
}
