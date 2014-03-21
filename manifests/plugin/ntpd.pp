# https://collectd.org/wiki/index.php/Plugin:NTPd
class collectd::plugin::ntpd (
  $ensure           = present,
  $host             = 'localhost',
  $port             = 123,
  $reverselookups   = false,
  $includeunitid    = false,
) {
  collectd::plugin {'ntpd':
    ensure  => $ensure,
    content => template('collectd/plugin/ntpd.conf.erb'),
  }
}
