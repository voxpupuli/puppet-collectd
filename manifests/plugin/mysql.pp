# MySQL plugin
# https://collectd.org/wiki/index.php/Plugin:MySQL
class collectd::plugin::mysql (
  $ensure           = 'present',
  $manage_package   = undef,
  $interval         = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $ensure == 'present' {
      $ensure_real = $collectd::package_ensure
    } elsif $ensure == 'absent' {
      $ensure_real = 'absent'
    }

    if $_manage_package {
      package { 'collectd-mysql':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'mysql':
    interval => $interval,
  }
}
