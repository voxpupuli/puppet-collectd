include collectd

class { 'collectd::plugin::irq':
  interfaces     => ['7', '23'],
  ignoreselected => 'true',
}
