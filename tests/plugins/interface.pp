include collectd

class { 'collectd::plugin::interface':
  interfaces     => ['eth0', 'eth1'],
  ignoreselected => true,
}
