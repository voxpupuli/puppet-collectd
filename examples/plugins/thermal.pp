include collectd

class { 'collectd::plugin::thermal':
  device         => ['foo0'],
  ignoreselected => false,
}
