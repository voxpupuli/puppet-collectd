class collectd::plugin::sensors (
  $sensorconfigfile = undef,
  $sensor           = undef,
  $ignoreselected   = undef,
  $ensure           = present
) {

  collectd::plugin {'sensors':
    ensure  => $ensure,
    content => template('collectd/plugin/sensors.conf.erb'),
  }
}
