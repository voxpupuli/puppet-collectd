# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  $ensure = present,
) {
  collectd::plugin {'cpu':
    ensure => $ensure
  }
}
