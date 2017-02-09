# https://collectd.org/wiki/index.php/Plugin:DF
class collectd::plugin::df (
  $ensure           = 'present',
  $devices          = [],
  $fstypes          = [],
  $ignoreselected   = false,
  $interval         = undef,
  $mountpoints      = [],
  $reportbydevice   = false,
  $reportinodes     = true,
  $reportreserved   = true,
  $valuesabsolute   = true,
  $valuespercentage = false,
) {

  include ::collectd

  validate_array(
    $devices,
    $fstypes,
    $mountpoints,
  )
  validate_bool(
    $ignoreselected,
    $reportbydevice,
    $reportinodes,
    $reportreserved,
    $valuesabsolute,
    $valuespercentage,
  )

  collectd::plugin { 'df':
    ensure   => $ensure,
    content  => template('collectd/plugin/df.conf.erb'),
    interval => $interval,
  }
}
