# https://collectd.org/wiki/index.php/Plugin:Sensors
class collectd::plugin::sensors (
  $ensure           = present,
  $manage_package   = $collectd::manage_package,
  $sensorconfigfile = undef,
  $sensor           = undef,
  $ignoreselected   = undef,
  $interval         = undef,
) {

  if $::osfamily == 'Redhat' {
    if $manage_package {
      package { 'collectd-sensors':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin {'sensors':
    ensure   => $ensure,
    content  => template('collectd/plugin/sensors.conf.erb'),
    interval => $interval,
  }
}
