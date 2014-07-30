# https://collectd.org/wiki/index.php/Plugin:DF
class collectd::plugin::df (
  $ensure           = present,
  $fstypes          = [],
  $ignoreselected   = false,
  $mountpoints      = [],
  $reportbydevice   = false,
  $reportinodes     = true,
  $reportreserved   = true,
  $valuesabsolute   = true,
  $valuespercentage = false,
) {

  validate_array(
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

  collectd::plugin {'df':
    ensure  => $ensure,
    content => template('collectd/plugin/df.conf.erb'),
  }
}
