# https://collectd.org/wiki/index.php/Plugin:memcached
class collectd::plugin::memcached (
  $ensure    = 'present',
  $instances = {'default' => {'host' => '127.0.0.1', 'port' => 11211 } },
  $interval  = undef,
) {

  include ::collectd

  validate_hash($instances)

  collectd::plugin { 'memcached':
    ensure   => $ensure,
    content  => template('collectd/plugin/memcached.conf.erb'),
    interval => $interval,
  }
}
