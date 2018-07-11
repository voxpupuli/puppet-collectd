# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_riemann (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $manage_package           = $collectd::manage_package,
  String[1] $riemann_host           = 'localhost',
  Variant[Integer,String[1]] $riemann_port = 5555,
  Enum['TCP', 'TLS', 'UDP'] $protocol = 'UDP',
  Boolean $batch                    = true,
  Boolean $store_rates              = false,
  Boolean $always_append_ds         = false,
  Variant[Float,String[1]] $ttl_factor = '2.0',
  Boolean $check_thresholds         = false,
  Array[String[1]] $tags               = [],
  Hash[String[1],String[1]] $attributes   = {},
) {

  include ::collectd

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
