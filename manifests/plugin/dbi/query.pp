#
define collectd::plugin::dbi::query (
  String $statement,
  String $ensure               = 'present',
  Array $results               = [{}],
  Optional[String] $minversion = undef,
  Optional[String] $maxversion = undef,
) {
  include collectd
  include collectd::plugin::dbi

  concat::fragment { "collectd_plugin_dbi_conf_query_${title}":
    order   => '30',
    target  => "${collectd::plugin_conf_dir}/dbi-config.conf",
    content => template('collectd/plugin/dbi/query.conf.erb'),
  }
}
