# https://collectd.org/wiki/index.php/Plugin:StatsD
class collectd::plugin::statsd (
  $countersum            = undef,
  $deletecounters        = undef,
  $deletegauges          = undef,
  $deletesets            = undef,
  $deletetimers          = undef,
  $ensure                = 'present',
  Optional[Stdlib::Host] $host = undef,
  $interval              = undef,
  Optional[Stdlib::Port] $port = undef,
  $timercount            = undef,
  $timerlower            = undef,
  Array $timerpercentile = [],
  $timersum              = undef,
  $timerupper            = undef
) {

  include collectd

  collectd::plugin { 'statsd':
    ensure   => $ensure,
    content  => template('collectd/plugin/statsd.conf.erb'),
    interval => $interval,
  }
}
