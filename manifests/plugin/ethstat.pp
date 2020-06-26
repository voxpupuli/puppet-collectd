# https://collectd.org/wiki/index.php/Plugin:Ethstat
class collectd::plugin::ethstat (
  $ensure           = 'present',
  Array $interfaces = [],
  Array $maps       = [],
  $mappedonly       = false,
  $interval         = undef,
) {
  include collectd

  collectd::plugin { 'ethstat':
    ensure   => $ensure,
    content  => template('collectd/plugin/ethstat.conf.erb'),
    interval => $interval,
  }
}
