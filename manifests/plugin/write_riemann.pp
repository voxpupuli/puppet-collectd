# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_riemann (
  $ensure           = present,
  $riemann_host     = 'localhost',
  $riemann_port     = 5555,
  $protocol         = 'UDP',
  $store_rates      = false,
  $always_append_ds = false,
) {
  validate_bool($store_rates)
  validate_bool($always_append_ds)

  collectd::plugin {'write_riemann':
    ensure  => $ensure,
    content => template('collectd/plugin/write_riemann.conf.erb'),
  }
}
