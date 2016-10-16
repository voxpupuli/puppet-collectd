#
define collectd::plugin::aggregation::aggregator (
  $ensure            = 'present',
  $host              = undef,
  $plugin            = undef,
  $plugininstance    = undef,
  $agg_type          = undef,
  $typeinstance      = undef,
  $sethost           = undef,
  $setplugin         = undef,
  $setplugininstance = undef,
  $settypeinstance   = undef,
  $groupby           = [],
  $calculatesum      = undef,
  $calculatenum      = undef,
  $calculateaverage  = undef,
  $calculateminimum  = undef,
  $calculatemaximum  = undef,
  $calculatestddev   = undef,
) {

  include ::collectd
  include ::collectd::plugin::aggregation

  $conf_dir = $collectd::plugin_conf_dir

  file { "${conf_dir}/aggregator-${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/plugin/aggregation-aggregator.conf.erb'),
    notify  => Service['collectd'],
  }
}
