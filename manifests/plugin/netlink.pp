# https://collectd.org/wiki/index.php/Plugin:Netlink
class collectd::plugin::netlink (
  $ensure                  = 'present',
  $manage_package          = undef,
  Array $interfaces        = [],
  Array $verboseinterfaces = [],
  Array $qdiscs            = [],
  Array $classes           = [],
  Array $filters           = [],
  Boolean $ignoreselected  = false,
  $interval                = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-netlink':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'netlink':
    ensure   => $ensure,
    content  => template('collectd/plugin/netlink.conf.erb'),
    interval => $interval,
  }
}
