# https://collectd.org/wiki/index.php/Plugin:BIND
class collectd::plugin::bind (
  $url,
  $ensure                 = 'present',
  $manage_package         = undef,
  Boolean $memorystats    = true,
  Boolean $opcodes        = true,
  Boolean $parsetime      = false,
  Boolean $qtypes         = true,
  Boolean $resolverstats  = false,
  Boolean $serverstats    = true,
  Boolean $zonemaintstats = true,
  Array $views            = [],
  $interval               = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-bind':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'bind':
    ensure   => $ensure,
    content  => template('collectd/plugin/bind.conf.erb'),
    interval => $interval,
  }
}
