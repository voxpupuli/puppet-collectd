# https://collectd.org/wiki/index.php/Plugin:Write_TSDB
class collectd::plugin::write_tsdb (
  $globals          = false,
  $host             = 'localhost',
  $port             = 4242,
  $host_tags        = null,
  $store_rates      = false,
  $always_append_ds = false,
) {
  validate_bool($globals)
  validate_bool($store_rates)
  validate_bool($always_append_ds)
  validate_string($host_tags)

  collectd::plugin {'write_tsdb':
    ensure   => $ensure,
    content  => template('collectd/plugin/write_tsdb.conf.erb'),
  }
}
