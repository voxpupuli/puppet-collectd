include collectd

class { 'collectd::plugin::write_prometheus':
  port => '9103',
}
