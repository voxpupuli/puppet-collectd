include collectd

class { 'collectd::plugin::disk':
  disks          => ['/^dm/'],
  ignoreselected => true,
}
