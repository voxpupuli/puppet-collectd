# https://collectd.org/wiki/index.php/Plugin:Redis
class collectd::plugin::redis (
  Enum['present', 'absent']              $ensure         = 'present',
  Optional[Integer[0]]                   $interval       = undef,
  Optional[Boolean]                      $manage_package = undef,
  Hash[String[1], Collectd::Redis::Node] $nodes          = {
    'redis' => {
      'host'    => 'localhost',
      'port'    => 6379,
      'timeout' => 2000,
      'queries' => {
        'dbsize' => {
          'type'  => 'count',
          'query' => 'DBSIZE',
        },
      },
    },
  },
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-redis':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'redis':
    ensure   => $ensure,
    content  => template('collectd/plugin/redis.conf.erb'),
    interval => $interval,
  }
}
