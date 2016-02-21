#
define collectd::plugin::dbi::query (
  $statement,
  $ensure     = 'present',
  $results    = [{}],
  $minversion = undef,
  $maxversion = undef,
) {
  include ::collectd
  include ::collectd::plugin::dbi

  validate_string($statement)
  validate_array($results)

  concat::fragment{ "collectd_plugin_dbi_conf_query_${title}":
    order   => '30',
    target  => "${collectd::plugin_conf_dir}/dbi-config.conf",
    content => template('collectd/plugin/dbi/query.conf.erb'),
  }
}
