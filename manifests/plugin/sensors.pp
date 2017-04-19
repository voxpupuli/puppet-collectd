# https://collectd.org/wiki/index.php/Plugin:Sensors
class collectd::plugin::sensors (
  $ensure                  = 'present',
  $manage_package          = undef,
  $sensorconfigfile        = undef,
  $sensor                  = undef,
  $ignoreselected          = undef,
  $interval                = undef,
  $package_install_options = $collectd::package_install_options,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $package_install_options != undef {
    validate_array($package_install_options)
  }

  if $::osfamily == 'Redhat' {
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
