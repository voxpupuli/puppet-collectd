# MySQL plugin
# https://collectd.org/wiki/index.php/Plugin:MySQL
class collectd::plugin::mysql (
  $ensure = undef
  $manage_package   = undef,
  $interval         = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
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
