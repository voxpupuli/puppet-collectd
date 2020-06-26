#
define collectd::plugin::postgresql::query (
  $ensure           = 'present',
  String $statement = undef,
  Array $params     = [],
  Array $results    = [{}],
  $minversion       = undef,
  $maxversion       = undef,
) {
  include collectd
  include collectd::plugin::postgresql

  concat::fragment { "collectd_plugin_postgresql_conf_query_${title}":
    order   => '30',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
    content => template('collectd/plugin/postgresql/query.conf.erb'),
  }
}
