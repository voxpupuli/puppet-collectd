# https://collectd.org/wiki/index.php/Plugin:Oracle
define collectd::plugin::oracle::query (
  String $statement,
  Array $results,
  String $query = $name,
) {
  include collectd
  include collectd::plugin::oracle

  $conf_dir = $collectd::plugin_conf_dir

  concat::fragment { "collectd_plugin_oracle_query_${name}":
    order   => '10',
    content => template('collectd/plugin/oracle/query.conf.erb'),
    target  => "${conf_dir}/15-oracle.conf",
  }
}
