#
define collectd::plugin::postgresql::query (
  $ensure     = 'present',
  $statement  = undef,
  $params     = [],
  $results    = [{}],
  $minversion = undef,
  $maxversion = undef,
) {

  include ::collectd
  include ::collectd::plugin::postgresql

  validate_string($statement)
  validate_array($params, $results)

  concat::fragment{ "collectd_plugin_postgresql_conf_query_${title}":
    order   => '30',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
    content => template('collectd/plugin/postgresql/query.conf.erb'),
  }
}
