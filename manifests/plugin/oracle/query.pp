# https://collectd.org/wiki/index.php/Plugin:Oracle
define collectd::plugin::oracle::query (
  $query           = $name,
  $statement,
  $results
) {

  include ::collectd
  include ::collectd::plugin::oracle

  validate_string($query)
  validate_string($statement)
  validate_hash($results)

  concat::fragment { "collectd_plugin_oracle_query_${name}":
    order   => '10',
    content => template('collectd/plugin/oracle/query.conf.erb'),
    target  => $collectd::plugin::oracle::config_file,
  }
}
