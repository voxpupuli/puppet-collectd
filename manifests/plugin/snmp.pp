# https://collectd.org/wiki/index.php/Plugin:SNMP
class collectd::plugin::snmp (
  Enum['present', 'absent']             $ensure         = 'present',
  Optional[Boolean]                     $manage_package = undef,
  Hash[String[1], Collectd::SNMP::Data] $data           = {},
  Hash[String[1], Collectd::SNMP::Host] $hosts          = {},
  Optional[Integer[0]]                  $interval       = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      if $ensure == 'present' {
        $ensure_real = $collectd::package_ensure
      } elsif $ensure == 'absent' {
        $ensure_real = 'absent'
      }

      package { 'collectd-snmp':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'snmp':
    ensure   => $ensure,
    content  => template('collectd/plugin/snmp.conf.erb'),
    interval => $interval,
  }
}
