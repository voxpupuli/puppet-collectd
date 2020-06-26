# https://collectd.org/wiki/index.php/Plugin:Uptime
class collectd::plugin::uptime (
  $ensure   = 'present',
  $interval = undef,
) {
  include collectd

  collectd::plugin { 'uptime':
    ensure   => $ensure,
    interval => $interval,
  }
}
