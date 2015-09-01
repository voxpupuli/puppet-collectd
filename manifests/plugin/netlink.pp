# https://collectd.org/wiki/index.php/Plugin:Netlink
class collectd::plugin::netlink (
  $ensure            = present,
  $interfaces        = [],
  $verboseinterfaces = [],
  $qdiscs            = [],
  $classes           = [],
  $filters           = [],
  $ignoreselected    = false,
  $interval          = undef,
) {

  validate_array($interfaces, $verboseinterfaces, $qdiscs, $classes, $filters)
  validate_bool($ignoreselected)

  if $::osfamily == 'Redhat' {
    package { 'collectd-netlink':
      ensure => $ensure,
    }
  }

  collectd::plugin {'netlink':
    ensure   => $ensure,
    content  => template('collectd/plugin/netlink.conf.erb'),
    interval => $interval,
  }
}
