include collectd

class { 'collectd::plugin::ethstat':
  maps       => ['"rx_csum_offload_errors" "if_rx_errors" checksum_offload"', '"multicast" "if_multicast"'],
  mappedonly => false,
}
