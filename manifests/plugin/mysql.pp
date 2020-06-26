# MySQL plugin
# https://collectd.org/wiki/index.php/Plugin:MySQL
class collectd::plugin::mysql (
  $ensure           = 'present',
  $interval         = undef,
  $manage_package   = undef
) {

  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-mysql':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'mysql':
    interval => $interval,
  }
}
