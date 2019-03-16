include collectd

class { 'collectd::plugin::write_graphite':
  graphitehost => 'graphite.cat.pdx.edu',
}
