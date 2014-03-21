# Redis plugin
# https://collectd.org/wiki/index.php/Plugin:Redis
#
class collectd::plugin::redis (
  $ensure      = 'present',
  $nodes       = { 'redis' => {
      'host'    => 'localhost',
      'port'    => '6379',
      'timeout' => '2000',
    }
  },
) {

  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  validate_hash($nodes)

  file { 'redis.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/redis.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/redis.conf.erb'),
    notify    => Service['collectd'],
  }
}
