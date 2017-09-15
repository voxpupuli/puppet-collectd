include ::collectd

class { '::collectd::plugin::iptables':
  chains  => {
    'nat'    => 'In_SSH',
    'filter' => 'HTTP',
  },
  chains6 => {
    'nat'    => 'In6_SSH',
    'filter' => 'HTTP6',
  },
}
