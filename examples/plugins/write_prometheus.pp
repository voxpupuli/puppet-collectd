include collectd

class { 'collectd::plugin::write_prometheus':
  port => '9103',
  # Optionally, pass the host parameter to bind to a specific ip
  host   => '127.0.0.1',
}
