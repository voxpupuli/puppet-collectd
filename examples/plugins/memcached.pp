include ::collectd

class { '::collectd::plugin::memcached':
  instances => {
    'default' => {
      'host' => '192.168.122.1',
      'port' => '11211',
    },
  },
}
