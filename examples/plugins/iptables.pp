include collectd

class { 'collectd::plugin::iptables':
  chains  => {
    'nat'    => 'In_SSH',
    'filter' => 'HTTP',
  },
  chains6 => {
    'filter' => 'HTTP6',
  },
}
