# databasename allows you to create <Database> blocks with the same name of database,
# useful if you have multiple instances of different version of pg
define collectd::plugin::postgresql::database (
  $ensure       = 'present',
  Optional[Stdlib::Host] $host = undef,
  $databasename = $name,
  Optional[Stdlib::Port] $port = undef,
  $user         = undef,
  $password     = undef,
  $sslmode      = undef,
  $query        = [],
  $interval     = undef,
  $instance     = undef,
  $krbsrvname   = undef,
  $writer       = undef,
  $service      = undef,
) {
  include collectd
  include collectd::plugin::postgresql

  concat::fragment { "collectd_plugin_postgresql_conf_db_${title}":
    order   => '50',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
    content => template('collectd/plugin/postgresql/database.conf.erb'),
  }
}
