# database allows you to create <Database> blocks with the same name of database,
#
define collectd::plugin::dbi::database (
  String $driver,
  String $ensure                          = 'present',
  Optional[String] $host                  = undef,
  String $databasename                    = $name,
  Hash $driveroption                      = {},
  Optional[String] $selectdb              = undef,
  Array $query                            = [],
  Optional[Integer[1]] $db_query_interval = undef,
) {
  include collectd
  include collectd::plugin::dbi

  concat::fragment { "collectd_plugin_dbi_conf_db_${title}":
    order   => '50',
    target  => "${collectd::plugin_conf_dir}/dbi-config.conf",
    content => template('collectd/plugin/dbi/database.conf.erb'),
  }
}
