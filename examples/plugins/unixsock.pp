include collectd

class { 'collectd::plugin::unixsock':
  socketfile  => '/var/run/collectd-sock',
  socketgroup => 'nagios',
}
