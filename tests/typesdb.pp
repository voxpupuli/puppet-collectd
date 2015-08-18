$typesdb = '/etc/collectd/types.db'

class { 'collectd':
  typesdb => [
    $typesdb,
  ],
}

collectd::typesdb { $typesdb: }
collectd::type {
  'bytes':
    target  => $typesdb,
    ds_type => 'GAUGE',
    min     => 0;
  'absolute':
    target  => $typesdb,
    ds      => 'absolute',
    ds_type => 'ABSOLUTE',
    ds_name => 'value',
    min     => '0',
    max     => 'U';
}
