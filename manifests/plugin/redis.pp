# https://collectd.org/wiki/index.php/Plugin:Redis
class collectd::plugin::redis (
  $ensure = undef
  $interval    = undef,
  $nodes       = { 'redis' => {
      'host'    => 'localhost',
      'port'    => '6379',
      'timeout' => 2000,
    },
  },
) {

  include ::collectd

  validate_hash($nodes)

  collectd::plugin { 'redis':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/redis.conf.erb'),
    interval => $interval,
  }
}
