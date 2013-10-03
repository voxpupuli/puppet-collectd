include collectd

class { 'collectd::plugin::irq':
  irqs           => ['7', '23'],
  ignoreselected => true,
}
