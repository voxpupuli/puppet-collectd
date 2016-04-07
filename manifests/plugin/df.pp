# https://collectd.org/wiki/index.php/Plugin:DF
class collectd::plugin::df (
  $ensure = undef
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
    ensure   => $ensure_real,
    content  => template('collectd/plugin/df.conf.erb'),
    interval => $interval,
  }
}
