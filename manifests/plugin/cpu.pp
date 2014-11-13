# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  $ensure   = present,
  $interval = undef,
) {
  collectd::plugin {'cpu':
    ensure   => $ensure,
    interval => $interval,
  }
}
