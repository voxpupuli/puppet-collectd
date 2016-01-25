# https://collectd.org/wiki/index.php/Plugin:Ethstat
class collectd::plugin::ethstat (
  $ensure     = present,
  $interfaces = [],
  $maps       = [],
  $mappedonly = false,
  $interval   = undef,
) {
  validate_array($interfaces,$maps)
  validate_bool($mappedonly)

  collectd::plugin {'ethstat':
    ensure   => $ensure,
    content  => template('collectd/plugin/ethstat.conf.erb'),
    interval => $interval,
  }
}
