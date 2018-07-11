# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_riemann (
  Enum['present', 'absent'] $ensure                 = 'present',
  Boolean $manage_package                           = $collectd::manage_package,
  Optional[String[1]] $riemann_host                 = undef,
  Optional[Variant[Integer,String[1]] $riemann_port = undef,
  Optional[Enum['TCP', 'TLS', 'UDP']] $protocol     = undef,
  Optional[Boolean] $batch                          = undef,
  Optional[Boolean] $store_rates                    = undef,
  Optional[Boolean] $always_append_ds               = undef,
  Optional[Variant[Float,String[1]]] $ttl_factor    = undef,
  Optional[Boolean] $check_thresholds               = undef,
  Array[String[1]] $tags                            = [],
  Hash[String[1],String[1]] $attributes             = {},
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
