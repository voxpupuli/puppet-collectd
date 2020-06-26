# https://collectd.org/wiki/index.php/Plugin:Swap
class collectd::plugin::swap (
  $ensure                   = 'present',
  $interval                 = undef,
  Boolean $reportbydevice   = false,
  Boolean $reportbytes      = true,
  Boolean $reportio         = true,
  Boolean $valuesabsolute   = true,
  Boolean $valuespercentage = false
) {

  include collectd

  collectd::plugin { 'swap':
    ensure   => $ensure,
    content  => epp('collectd/plugin/swap.conf.epp'),
    interval => $interval,
  }
}
