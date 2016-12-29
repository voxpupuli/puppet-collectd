# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_riemann (
  $ensure           = 'present',
  $manage_package   = undef,
  $riemann_host     = 'localhost',
  $riemann_port     = 5555,
  $protocol         = 'UDP',
  $batch            = true,
  $store_rates      = false,
  $always_append_ds = false,
  $interval         = undef,
  $ttl_factor       = '2.0',
  $check_thresholds = false,
  $tags             = [],
  $attributes       = {},
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_bool($store_rates)
  validate_bool($always_append_ds)
  validate_bool($batch)
  validate_bool($check_thresholds)
  validate_numeric($ttl_factor)
  validate_array($tags)
  validate_hash($attributes)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-write_riemann':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'write_riemann':
    ensure   => $ensure,
    content  => template('collectd/plugin/write_riemann.conf.erb'),
    interval => $interval,
  }
}
