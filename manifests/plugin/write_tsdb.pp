# https://collectd.org/wiki/index.php/Plugin:Write_TSDB
class collectd::plugin::write_tsdb (
  $ensure                   = present,
  Boolean $globals          = false,
  Stdlib::Host $host        = 'localhost',
  Stdlib::Port $port        = 4242,
  Array $host_tags          = [],
  Boolean $store_rates      = false,
  Boolean $always_append_ds = false,
) {
  include collectd

  collectd::plugin { 'write_tsdb':
    ensure  => $collectd::plugin::write_tsdb::ensure,
    content => template('collectd/plugin/write_tsdb.conf.erb'),
  }
}
