# databasename allows you to create <Database> blocks with the same name of database,
# useful if you have multiple instances of different version of pg
define collectd::plugin::postgresql::database (
  $ensure       = 'present',
  $host         = undef,
  $databasename = $name,
  $port         = undef,
  $user         = undef,
  $password     = undef,
  $sslmode      = undef,
  $query        = [],
  $interval     = undef,
  $instance     = undef,
  $krbsrvname   = undef,
  $writer       = undef,
  $service      = undef,
){
  include ::collectd::params
  include ::collectd::plugin::postgresql

  concat::fragment{"collectd_plugin_postgresql_conf_db_${title}":
    ensure  => $ensure,
    order   => '50',
    target  => "${collectd::params::plugin_conf_dir}/postgresql-config.conf",
    content => template('collectd/plugin/postgresql/database.conf.erb'),
  }
}
