# https://collectd.org/wiki/index.php/Plugin:DF
class collectd::plugin::df (
  $ensure         = present,
  $fstypes        = [],
  $ignoreselected = false,
  $mountpoints    = [],
  $reportbydevice = false,
  $reportinodes   = true,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_array(
    $fstypes,
    $mountpoints,
  )
  validate_bool(
    $ignoreselected,
    $reportbydevice,
    $reportinodes,
  )

  file { 'df.conf':
    ensure    => $collectd::plugin::df::ensure,
    path      => "${conf_dir}/df.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/df.conf.erb'),
    notify    => Service['collectd'],
  }
}
