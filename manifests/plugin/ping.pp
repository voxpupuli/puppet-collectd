# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ping
class collectd::plugin::ping (
  $hosts,
  $ensure         = 'present',
  $manage_package = undef,
  $interval       = undef,
  $timeout        = undef,
  $ttl            = undef,
  $source_address = undef,
  $device         = undef,
  $max_missed     = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_array($hosts)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-ping':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'ping':
    ensure   => $ensure,
    interval => $interval,
    content  => template('collectd/plugin/ping.conf.erb'),
  }
}
