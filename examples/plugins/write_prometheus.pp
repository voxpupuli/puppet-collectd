include collectd

class { 'collectd::plugin::write_prometheus':
  port => '9103',
  # Optionally, pass the ip parameter to bind to a specific ip
  ip   => '127.0.0.1',
}
