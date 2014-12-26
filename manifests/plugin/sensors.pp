# https://collectd.org/wiki/index.php/Plugin:Sensors
class collectd::plugin::sensors (
  $ensure           = present,
  $sensorconfigfile = undef,
  $sensor           = undef,
  $ignoreselected   = undef,
  $interval         = undef,
) {

  collectd::plugin {'sensors':
    ensure   => $ensure,
    content  => template('collectd/plugin/sensors.conf.erb'),
    interval => $interval,
  }
}
