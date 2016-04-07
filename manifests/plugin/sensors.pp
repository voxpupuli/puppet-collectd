# https://collectd.org/wiki/index.php/Plugin:Sensors
class collectd::plugin::sensors (
  $ensure           = 'present',
  $manage_package   = undef,
  $sensorconfigfile = undef,
  $sensor           = undef,
  $ignoreselected   = undef,
  $interval         = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-sensors':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'sensors':
    ensure   => $ensure,
    content  => template('collectd/plugin/sensors.conf.erb'),
    interval => $interval,
  }
}
