# https://collectd.org/wiki/index.php/Plugin:Swap
class collectd::plugin::swap (
  $ensure = undef
  $interval         = undef,
  $reportbydevice   = false,
  $reportbytes      = true,
  $valuesabsolute   = true,
  $valuespercentage = false,
) {

  include ::collectd

  validate_bool(
    $reportbydevice,
    $reportbytes,
    $valuesabsolute,
    $valuespercentage
  )

  collectd::plugin { 'swap':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/swap.conf.erb'),
    interval => $interval,
  }
}
