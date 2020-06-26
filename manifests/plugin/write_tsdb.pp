# https://collectd.org/wiki/index.php/Plugin:Write_TSDB
class collectd::plugin::write_tsdb (
  Boolean $always_append_ds = false,
  $ensure                   = present,
  Boolean $globals          = false,
  Stdlib::Host $host        = 'localhost',
  Array $host_tags          = [],
  Stdlib::Port $port        = 4242,
  Boolean $store_rates      = false
) {

  include collectd

  collectd::plugin {'write_tsdb':
    ensure  => $collectd::plugin::write_tsdb::ensure,
    content => template('collectd/plugin/write_tsdb.conf.erb'),
  }
}
