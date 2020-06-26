# https://collectd.org/wiki/index.php/Plugin:Netlink
class collectd::plugin::netlink (
  Array $classes           = [],
  $ensure                  = 'present',
  Array $filters           = [],
  Boolean $ignoreselected  = false,
  Array $interfaces        = [],
  $interval                = undef,
  $manage_package          = undef,
  Array $qdiscs            = [],
  Array $verboseinterfaces = []
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
