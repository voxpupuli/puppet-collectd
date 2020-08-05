# https://collectd.org/wiki/index.php/Plugin:Oracle
define collectd::plugin::oracle::database (
  String $username,
  String $password,
  Array $query,
  String $connect_id = $name,
  String $database   = $name,
) {
  include collectd
  include collectd::plugin::oracle

  $conf_dir = $collectd::plugin_conf_dir

  concat::fragment { "collectd_plugin_oracle_database_${name}":
    order   => '20',
    content => template('collectd/plugin/oracle/database.conf.erb'),
    target  => "${conf_dir}/15-oracle.conf",
  }
}
