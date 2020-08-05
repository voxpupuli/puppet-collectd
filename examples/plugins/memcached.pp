include collectd

class { 'collectd::plugin::memcached':
  instances => {
    'default' => {
      'host'    => 'localhost',
      'address' => '127.0.0.1',
      'port'    => '11211',
    },
  },
}
