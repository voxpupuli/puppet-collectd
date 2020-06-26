# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_riemann (
  Array[Collectd::Write_riemann::Node] $nodes,
  Enum['present', 'absent'] $ensure     = 'present',
  Boolean $manage_package               = $collectd::manage_package,
  Array[String[1]] $tags                = [],
  Hash[String[1],String[1]] $attributes = {},
) {
  include collectd

  if $facts['os']['family'] == 'RedHat' {
    if $manage_package {
      package { 'collectd-write_riemann':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'write_riemann':
    ensure  => $ensure,
    content => epp('collectd/plugin/write_riemann.conf.epp'),
  }
}
