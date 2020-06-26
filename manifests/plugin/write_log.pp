class collectd::plugin::write_log (
  String $format = 'JSON',
  $ensure        = 'present',
) {
  include collectd

  collectd::plugin { 'write_log':
    ensure  => $ensure,
    content => template('collectd/plugin/write_log.conf.erb'),
  }
}
