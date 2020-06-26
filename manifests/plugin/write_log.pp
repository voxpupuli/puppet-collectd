class collectd::plugin::write_log (
  $ensure        = 'present',
  String $format = 'JSON'
) {

  include collectd

  collectd::plugin { 'write_log':
    ensure  => $ensure,
    content => template('collectd/plugin/write_log.conf.erb'),
  }
}
