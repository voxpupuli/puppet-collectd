# https://collectd.org/wiki/index.php/Plugin:Sensors
class collectd::plugin::sensors (
  $ensure           = 'present',
  $ignoreselected   = undef,
  $interval         = undef,
  $manage_package   = undef,
  Optional[Array[String]] $package_install_options = undef,
  $sensorconfigfile = undef,
  $sensors          = undef
) {

  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-sensors':
        ensure          => $ensure,
        install_options => $package_install_options,
      }
    }
  }

  collectd::plugin { 'sensors':
    ensure   => $ensure,
    content  => template('collectd/plugin/sensors.conf.erb'),
    interval => $interval,
  }
}
