# https://collectd.org/wiki/index.php/Plugin:Oracle
define collectd::plugin::oracle::database (
  String $username,
  String $password,
  Array $query,
  String $connect_id = $name,
  String $database   = $name,
) {

  include ::collectd
  include ::collectd::plugin::oracle

  concat::fragment { "collectd_plugin_oracle_database_${name}":
    order   => '20',
    content => template('collectd/plugin/oracle/database.conf.erb'),
    target  => $collectd::plugin::oracle::config_file,
  }
}
