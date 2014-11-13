# https://collectd.org/wiki/index.php/Plugin:Memory
class collectd::plugin::memory (
  $ensure   = present,
  $interval = undef,
) {
  collectd::plugin {'memory':
    ensure   => $ensure,
    interval => $interval,
  }
}
