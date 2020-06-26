# https://collectd.org/wiki/index.php/Plugin:NTPd
class collectd::plugin::ntpd (
  $ensure           = 'present',
  Stdlib::Host $host = 'localhost',
  $includeunitid    = false,
  $interval         = undef,
  Stdlib::Port $port = 123,
  $reverselookups   = false
) {

  include collectd

  collectd::plugin { 'ntpd':
    ensure   => $ensure,
    content  => template('collectd/plugin/ntpd.conf.erb'),
    interval => $interval,
  }
}
