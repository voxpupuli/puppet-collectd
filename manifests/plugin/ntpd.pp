# https://collectd.org/wiki/index.php/Plugin:NTPd
class collectd::plugin::ntpd (
  $ensure = undef
  $host             = 'localhost',
  $port             = 123,
  $reverselookups   = false,
  $includeunitid    = false,
  $interval         = undef,
) {

  include ::collectd

  collectd::plugin { 'ntpd':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/ntpd.conf.erb'),
    interval => $interval,
  }
}
