# https://collectd.org/wiki/index.php/Plugin:LVM
class collectd::plugin::lvm (
  $ensure           = 'present',
  $manage_package   = undef,
  $interval         = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $ensure == 'present' {
    $ensure_real = $collectd::package_ensure
  } elsif $ensure == 'absent' {
    $ensure_real = 'absent'
  }

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-lvm':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'lvm':
    ensure   => $ensure,
    interval => $interval,
  }
}
