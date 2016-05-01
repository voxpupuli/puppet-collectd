# https://collectd.org/wiki/index.php/Plugin:Write_TSDB
class collectd::plugin::write_tsdb (
  $ensure           = present,
  $globals          = false,
  $host             = 'localhost',
  $port             = 4242,
  $host_tags        = [],
  $store_rates      = false,
  $always_append_ds = false,
) {
  validate_bool($globals)
  validate_bool($store_rates)
  validate_bool($always_append_ds)
  validate_array($host_tags)

  include ::collectd

  collectd::plugin {'write_tsdb':
    ensure  => $collectd::plugin::write_tsdb::ensure,
    content => template('collectd/plugin/write_tsdb.conf.erb'),
  }
}
