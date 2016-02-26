# https://collectd.org/wiki/index.php/Plugin:LVM
class collectd::plugin::lvm (
  $ensure           = 'present',
  $manage_package   = undef,
  $interval         = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-lvm':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'lvm':
    ensure   => $ensure,
    interval => $interval,
  }
}
