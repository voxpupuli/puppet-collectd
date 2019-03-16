include collectd

class { 'collectd::plugin::smart':
  disks          => ['/^dm/'],
  ignoreselected => true,
}
