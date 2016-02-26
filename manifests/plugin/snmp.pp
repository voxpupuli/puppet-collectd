# https://collectd.org/wiki/index.php/Plugin:SNMP
class collectd::plugin::snmp (
  $ensure         = 'present',
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
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'snmp':
    ensure   => $ensure,
    content  => template('collectd/plugin/snmp.conf.erb'),
    interval => $interval,
  }
}
