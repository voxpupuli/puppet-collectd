# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_riemann (
  $ensure                           = 'present',
  $manage_package                   = undef,
  $riemann_host                     = 'localhost',
  $riemann_port                     = 5555,
  $protocol                         = 'UDP',
  Boolean $batch                    = true,
  Boolean $store_rates              = false,
  Boolean $always_append_ds         = false,
  Variant[Float,String] $ttl_factor = '2.0',
  Boolean $check_thresholds         = false,
  Array $tags                       = [],
  Hash $attributes                  = {},
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-write_riemann':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'write_riemann':
    ensure  => $ensure,
    content => template('collectd/plugin/write_riemann.conf.erb'),
  }
}
