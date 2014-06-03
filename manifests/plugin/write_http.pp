# https://collectd.org/wiki/index.php/Plugin:Write_HTTP
class collectd::plugin::write_http (
  $ensure     = present,
  $urls  = {},
) {

  validate_hash($urls)

  collectd::plugin {'write_http':
    ensure  => $ensure,
    content => template('collectd/plugin/write_http.conf.erb'),
  }
}
