include collectd

class { 'collectd::plugin::netlink':
  interfaces        => ['eth0', 'eth1'],
  verboseinterfaces => ['ppp0'],
  qdiscs            => ['"eth0" "pfifo_fast-1:0"', '"ppp0"'],
  classes           => ['"ppp0" "htb-1:10"'],
  filters           => ['"ppp0" "u32-1:0"'],
  ignoreselected    => false,
}
