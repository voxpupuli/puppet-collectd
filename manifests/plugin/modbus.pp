# https://collectd.org/wiki/index.php/Plugin:Modbus
class collectd::plugin::modbus (
  Enum['present', 'absent']               $ensure         = 'present',
  Optional[Boolean]                       $manage_package = undef,
  Hash[String[1], Collectd::Modbus::Data] $data           = {},
  Hash[String[1], Collectd::Modbus::Host] $hosts          = {},
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-modbus':
        ensure => $ensure,
      }
    }
  }

  if $facts['os']['family'] == 'Debian' {
    if $_manage_package {
      package { 'libmodbus5':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'modbus':
    ensure   => $ensure,
    content  => template('collectd/plugin/modbus.conf.erb'),
  }
}
