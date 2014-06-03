# https://collectd.org/wiki/index.php/Plugin:StatsD
class collectd::plugin::statsd (
  $ensure          = present,
  $host            = undef,
  $port            = undef,
  $deletecounters  = undef,
  $deletetimers    = undef,
  $deletegauges    = undef,
  $deletesets      = undef,
  $timerpercentile = undef,
) {

  collectd::plugin {'statsd':
    ensure  => $ensure,
    content => template('collectd/plugin/statsd.conf.erb'),
  }
}
