include collectd

class { 'collectd::plugin::snmp':
  data  => {
    amavis_incoming_messages => {
      'type'     => 'counter',
      'table'    => false,
      'instance' => 'amavis.inMsgs',
      'values'   => ['AMAVIS-MIB::inMsgs.0'],
    },
  },
  hosts => {
    scan04 => {
      'address'   => '127.0.0.1',
      'version'   => 2,
      'community' => 'public',
      'collect'   => ['amavis_incoming_messages'],
      'interval'  => 10,
    },
  },
}
