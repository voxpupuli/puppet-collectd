# https://collectd.org/wiki/index.php/Plugin:SNMP
class collectd::plugin::snmp (
  $ensure         = present,
  $manage_package = $collectd::manage_package,
  $data           = {},
  $hosts          = {},
  $interval       = undef,
) {
  if $::osfamily == 'Redhat' {
    if $manage_package {
      package { 'collectd-snmp':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin {'snmp':
    ensure   => $ensure,
    content  => template('collectd/plugin/snmp.conf.erb'),
    interval => $interval,
  }
}
