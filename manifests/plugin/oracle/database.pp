# https://collectd.org/wiki/index.php/Plugin:Oracle
define collectd::plugin::oracle::database (
  $database           = $name,
  $connect_id,
  $username,
  $password,
  $query,
) {

  include ::collectd
  include ::collectd::plugin::oracle

  validate_string($database)
  validate_string($connect_id)
  validate_string($username)
  validate_string($password)

  concat::fragment { "collectd_plugin_oracle_database_${name}":
    order   => '10',
    content => template('collectd/plugin/oracle/database.conf.erb'),
    target  => $collectd::plugin::oracle::config_file,
  }
}
