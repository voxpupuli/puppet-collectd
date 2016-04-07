# https://collectd.org/wiki/index.php/Plugin:Write_HTTP
class collectd::plugin::write_http (
  $ensure = undef
  $interval = undef,
  $urls     = {},
) {

  include ::collectd

  validate_hash($urls)

  collectd::plugin { 'write_http':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/write_http.conf.erb'),
    interval => $interval,
  }
}
