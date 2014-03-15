# https://collectd.org/wiki/index.php/Plugin:Memory
class collectd::plugin::memory (
  $ensure = present,
) {
  collectd::plugin {'memory':
    ensure => $ensure
  }
}
