class collectd::plugin::write_prometheus (
  $port   = '9103',
  $ensure = 'present',
) {

  include ::collectd

  validate_string($port)

  collectd::plugin { 'write_prometheus':
    ensure  => $ensure,
    content => template('collectd/plugin/write_prometheus.conf.erb'),
  }
}
