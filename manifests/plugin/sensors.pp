# https://collectd.org/wiki/index.php/Plugin:Sensors
class collectd::plugin::sensors (
  $ensure = undef
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
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'sensors':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/sensors.conf.erb'),
    interval => $interval,
  }
}
