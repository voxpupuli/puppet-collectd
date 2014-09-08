#
define collectd::plugin::postgresql::query (
  $ensure     = 'present',
  $statement  = undef,
  $params     = [],
  $results    = [{}],
  $minversion = undef,
  $maxversion = undef,
){
  include collectd::params
  include collectd::plugin::postgresql

  validate_string($statement)
  validate_array($params, $results)

  concat::fragment{"collectd_plugin_postgresql_conf_query_${title}":
    ensure  => $ensure,
    order   => '30',
    target  => "${collectd::params::plugin_conf_dir}/postgresql-config.conf",
    content => template('collectd/plugin/postgresql/query.conf.erb'),
  }
}
