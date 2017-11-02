class collectd::plugin::write_prometheus (
  String $port = '9103',
  $ensure      = 'present',
) {

  include ::collectd

  collectd::plugin { 'write_prometheus':
    ensure  => $ensure,
    content => template('collectd/plugin/write_prometheus.conf.erb'),
  }
}
