# @summary Enable write_http plugin
#
# @see  https://collectd.org/wiki/index.php/Plugin:Write_HTTP
#
# @parameter Manage a collectd-write_http package? If undef a suitable value per OS will be chosen.
#
class collectd::plugin::write_http (
  Enum['present', 'absent']          $ensure = 'present',
  Hash[String, Hash[String, Scalar]] $nodes = {},
  Hash[String, Hash[String, Scalar]] $urls  = {},
  Optional[Boolean]                  $manage_package = undef,
) {
  include collectd

  if !empty($nodes) and !empty($urls) {
    fail('Only one of nodes or urls is supposed to be defined')
  }

  if $manage_package !~ Undef {
    $_manage_package = $manage_package
  } else {
    if $facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'],'8') >= 0 {
      $_manage_package = true
    } else {
      $_manage_package = false
    }
  }
  if $_manage_package {
    package { 'collectd-write_http':
      ensure => $ensure,
    }
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
