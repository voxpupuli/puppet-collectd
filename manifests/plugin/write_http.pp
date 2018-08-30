# https://collectd.org/wiki/index.php/Plugin:Write_HTTP
class collectd::plugin::write_http (
  Enum['present', 'absent']          $ensure = 'present',
  Hash[String, Hash[String, Scalar]] $nodes = {},
  Hash[String, Hash[String, Scalar]] $urls  = {}
) {

  include ::collectd

  if !empty($nodes) and !empty($urls) {
    fail('Only one of nodes or urls is supposed to be defined')
  }

  $endpoints = merge($nodes, $urls)
  collectd::plugin { 'write_http':
    ensure  => $ensure,
    content => epp('collectd/plugin/write_http.conf.epp',
      {
        'endpoints' => $endpoints
      }
    ),
  }
}
