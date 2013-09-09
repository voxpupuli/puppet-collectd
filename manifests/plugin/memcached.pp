class collectd::plugin::memcached (
  $host   = '127.0.0.1',
  $port   = '11211',
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'memcached.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/memcached.conf",
    mode      => 0644,
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/memcached.conf.erb'),
    notify    => Service['collectd']
  }
}

