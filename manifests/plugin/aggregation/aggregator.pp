#
define collectd::plugin::aggregation::aggregator (
  String $ensure                          = 'present',
  Optional[String] $host                  = undef,
  Optional[String] $plugin                = undef,
  Optional[Integer[0]] $plugininstance    = undef,
  Optional[String] $agg_type              = undef,
  Optional[String] $typeinstance          = undef,
  Optional[String] $sethost               = undef,
  Optional[String] $setplugin             = undef,
  Optional[Integer[0]] $setplugininstance = undef,
  Optional[String] $settypeinstance       = undef,
  Array[String] $groupby                  = [],
  Optional[Boolean] $calculatesum         = undef,
  Optional[Boolean] $calculatenum         = undef,
  Optional[Boolean] $calculateaverage     = undef,
  Optional[Boolean] $calculateminimum     = undef,
  Optional[Boolean] $calculatemaximum     = undef,
  Optional[Boolean] $calculatestddev      = undef,
) {
  include collectd
  include collectd::plugin::aggregation

  $conf_dir = $collectd::plugin_conf_dir

  file { "${conf_dir}/aggregator-${name}.conf":
    ensure  => $ensure,
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/plugin/aggregation-aggregator.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
