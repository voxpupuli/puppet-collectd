# https://collectd.org/wiki/index.php/Plugin:Load
class collectd::plugin::load (
  $ensure = present,
) {
  collectd::plugin {'load':
    ensure => $ensure
  }
}
