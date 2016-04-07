# https://collectd.org/wiki/index.php/Plugin:Uptime
class collectd::plugin::uptime (
  $ensure = undef
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'uptime':
    ensure   => $ensure_real,
    interval => $interval,
  }
}
