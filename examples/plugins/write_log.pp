include collectd

class { 'collectd::plugin::write_log':
  format => 'JSON',
}
