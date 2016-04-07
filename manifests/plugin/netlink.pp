# https://collectd.org/wiki/index.php/Plugin:Netlink
class collectd::plugin::netlink (
  $ensure = undef
  $manage_package    = true,
  $interfaces        = [],
  $verboseinterfaces = [],
  $qdiscs            = [],
  $classes           = [],
  $filters           = [],
  $ignoreselected    = false,
  $interval          = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_array($interfaces, $verboseinterfaces, $qdiscs, $classes, $filters)
  validate_bool($ignoreselected)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-netlink':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'netlink':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/netlink.conf.erb'),
    interval => $interval,
  }
}
