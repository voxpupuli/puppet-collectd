# https://collectd.org/wiki/index.php/Plugin:Load
class collectd::plugin::load (
  $ensure   = present,
  $interval = undef,
) {
  collectd::plugin {'load':
    ensure   => $ensure,
    interval => $interval,
  }
}
