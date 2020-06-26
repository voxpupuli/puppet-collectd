# https://collectd.org/wiki/index.php/Plugin:Ethstat
class collectd::plugin::ethstat (
  $ensure           = 'present',
  Array $interfaces = [],
  $interval         = undef,
  $mappedonly       = false,
  Array $maps       = []
) {

  include collectd

  collectd::plugin { 'ethstat':
    ensure   => $ensure,
    content  => template('collectd/plugin/ethstat.conf.erb'),
    interval => $interval,
  }
}
