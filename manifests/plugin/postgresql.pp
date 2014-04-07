# https://collectd.org/wiki/index.php/Plugin:PostgreSQL
class collectd::plugin::postgresql (
  $ensure    = present,
  $databases = { 'postgres' => {
    'host'       => undef,
    'port'       => undef,
    'user'       => undef,
    'password'   => undef,
    'sslmode'    => undef,
    'query'      => [],
    'interval'   => undef,
    'instance'   => undef,
    'krbsrvname' => undef,
    'service'    => undef,
    }
  },
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_hash($databases)

  file { 'postgresql.conf':
    ensure    => $collectd::plugin::postgresql::ensure,
    path      => "${conf_dir}/postgresql.conf",
    mode      => '0640',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/postgresql.conf.erb'),
    notify    => Service['collectd']
  }
}
