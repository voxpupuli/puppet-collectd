include collectd

class { 'collectd::plugin::write_graphite':
  host => 'graphite.cat.pdx.edu',
}
