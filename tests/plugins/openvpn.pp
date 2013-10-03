include collectd

class { 'collectd::plugin::openvpn':
  collectindividualusers => false,
  collectusercount       => true,
}
