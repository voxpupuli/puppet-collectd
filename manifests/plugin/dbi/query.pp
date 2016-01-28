#
define collectd::plugin::dbi::query (
  $statement,
  $ensure     = 'present',
  $results    = [{}],
  $minversion = undef,
  $maxversion = undef,
){
  include ::collectd::params
  include ::collectd::plugin::dbi

  validate_string($statement)
  validate_array($results)

  concat::fragment{"collectd_plugin_dbi_conf_query_${title}":
    ensure  => $ensure,
    order   => '30',
    target  => "${collectd::params::plugin_conf_dir}/dbi-config.conf",
    content => template('collectd/plugin/dbi/query.conf.erb'),
  }
}
