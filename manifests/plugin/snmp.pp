# https://collectd.org/wiki/index.php/Plugin:SNMP
class collectd::plugin::snmp (
  $ensure = undef
  $manage_package = undef,
  $data           = {},
  $hosts          = {},
  $interval       = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-snmp':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'snmp':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/snmp.conf.erb'),
    interval => $interval,
  }
}
