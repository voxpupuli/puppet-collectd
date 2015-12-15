include collectd

class { 'collectd::plugin::syslog':
  log_level => 'debug',
}
