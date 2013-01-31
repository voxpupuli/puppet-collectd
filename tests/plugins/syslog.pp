include collectd

class { 'collectd::plugin::syslog':
  loglevel => 'debug'
}
