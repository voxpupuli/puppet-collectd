include collectd

class { 'collectd::plugin::uuid':
  uuid_file => '/etc/uuid',
}
