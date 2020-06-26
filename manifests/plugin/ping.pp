# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ping
class collectd::plugin::ping (
  Array $hosts,
  Enum['present', 'absent'] $ensure = 'present',
  Optional[Boolean] $manage_package = undef,
  Optional[Numeric] $interval       = undef,
  Optional[Numeric] $timeout        = undef,
  Optional[Integer[0,255]] $ttl     = undef,
  Optional[String] $source_address  = undef,
  Optional[String] $device          = undef,
  Optional[Integer[-1]] $max_missed = undef,
  Optional[Integer[0]] $size        = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-ping':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'ping':
    ensure   => $ensure,
    interval => $interval,
    content  => epp('collectd/plugin/ping.conf.epp'),
  }
}
