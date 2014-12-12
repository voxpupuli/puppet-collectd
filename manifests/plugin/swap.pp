# https://collectd.org/wiki/index.php/Plugin:Swap
class collectd::plugin::swap (
  $ensure         = present,
  $interval       = undef,
  $reportbydevice = false,
  $reportbytes    = true,
) {
  validate_bool(
    $reportbydevice,
    $reportbytes
  )

  collectd::plugin {'swap':
    ensure   => $ensure,
    content  => template('collectd/plugin/swap.conf.erb'),
    interval => $interval,
  }
}
