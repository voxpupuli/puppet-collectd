include collectd

class { 'collectd::plugin::hddtemp':
  host => '127.0.0.1',
  port => 7634,
}
