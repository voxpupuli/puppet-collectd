class collectd::plugin::write_prometheus (
  $ensure            = 'present',
  Stdlib::Port $port = 9103
) {

  include collectd

  collectd::plugin { 'write_prometheus':
    ensure  => $ensure,
    content => template('collectd/plugin/write_prometheus.conf.erb'),
  }
}
