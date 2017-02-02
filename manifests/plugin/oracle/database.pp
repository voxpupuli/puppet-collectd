# https://collectd.org/wiki/index.php/Plugin:Oracle
define collectd::plugin::oracle::database (
  $username,
  $password,
  $query,
  $connect_id = $name,
  $database = $name,
) {

  include ::collectd
  include ::collectd::plugin::oracle

  validate_string($database)
  validate_string($connect_id)
  validate_string($username)
  validate_string($password)
  validate_array($query)

  concat::fragment { "collectd_plugin_oracle_database_${name}":
    order   => '20',
    content => template('collectd/plugin/oracle/database.conf.erb'),
    target  => $collectd::plugin::oracle::config_file,
  }
}
