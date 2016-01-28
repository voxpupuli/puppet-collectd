# database allows you to create <Database> blocks with the same name of database,
#
define collectd::plugin::dbi::database (
  $driver,
  $ensure       = 'present',
  $host         = undef,
  $databasename = $name,
  $driveroption = {},
  $selectdb     = undef,
  $query        = [],
){
  include ::collectd::params
  include ::collectd::plugin::dbi

  validate_string($driver)
  validate_hash($driveroption)
  validate_array($query)

  concat::fragment{"collectd_plugin_dbi_conf_db_${title}":
    ensure  => $ensure,
    order   => '50',
    target  => "${collectd::params::plugin_conf_dir}/dbi-config.conf",
    content => template('collectd/plugin/dbi/database.conf.erb'),
  }
}
