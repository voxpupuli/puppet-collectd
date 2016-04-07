#
define collectd::plugin::aggregation::aggregator (
  $ensure            = undef
  $host              = undef,
  $plugin            = undef,
  $plugininstance    = undef,
  $type              = undef,
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

  $ensure_real = pick($ensure, 'file')
  
  file { "${conf_dir}/aggregator-${name}.conf":
    ensure  => $ensure_real,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/plugin/aggregation-aggregator.conf.erb'),
    notify  => Service['collectd'],
  }
}
