include collectd

class { 'collectd::plugin::ceph':
  osds          => ['osd.0', 'osd.1', 'osd.2'],
}
