# https://collectd.org/wiki/index.php/Plugin:DF
class collectd::plugin::df (
  Array $devices            = [],
  $ensure                   = 'present',
  Array $fstypes            = [],
  Boolean $ignoreselected   = false,
  $interval                 = undef,
  Array $mountpoints        = [],
  Boolean $reportbydevice   = false,
  Boolean $reportinodes     = true,
  Boolean $reportreserved   = true,
  Boolean $valuesabsolute   = true,
  Boolean $valuespercentage = false
) {

  include collectd

  collectd::plugin { 'df':
    ensure   => $ensure,
    content  => template('collectd/plugin/df.conf.erb'),
    interval => $interval,
  }
}
