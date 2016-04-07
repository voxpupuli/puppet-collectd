# https://collectd.org/wiki/index.php/Plugin:BIND
class collectd::plugin::bind (
  $url,
  $ensure = undef
  $manage_package = undef,
  $memorystats    = true,
  $opcodes        = true,
  $parsetime      = false,
  $qtypes         = true,
  $resolverstats  = false,
  $serverstats    = true,
  $zonemaintstats = true,
  $views          = [],
  $interval       = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_bool(
    $memorystats,
    $opcodes,
    $parsetime,
    $qtypes,
    $resolverstats,
    $serverstats,
    $zonemaintstats,
  )
  validate_array($views)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-bind':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'bind':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/bind.conf.erb'),
    interval => $interval,
  }
}
