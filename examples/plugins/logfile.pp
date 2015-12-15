include collectd

class { 'collectd::plugin::logfile':
  log_level => 'debug',
}
