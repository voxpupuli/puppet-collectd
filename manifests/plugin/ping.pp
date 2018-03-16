# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ping
class collectd::plugin::ping (
  Array $hosts,
  $ensure         = 'present',
  $manage_package = undef,
  $interval       = undef,
  $ping_interval  = undef,
  $timeout        = undef,
  $ttl            = undef,
  $source_address = undef,
  $device         = undef,
  $max_missed     = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-ping':
        ensure => $ensure,
      }
    }
  }

  if versioncmp($::collectd::collectd_version_real, '5.2') < 0 and $interval and ! $ping_interval {
    $_ping_interval = $interval
  } else {
    $_ping_interval = $ping_interval
  }

  collectd::plugin { 'ping':
    ensure   => $ensure,
    interval => $interval,
    content  => template('collectd/plugin/ping.conf.erb'),
  }
}
