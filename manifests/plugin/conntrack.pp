# https://collectd.org/wiki/index.php/Plugin:ConnTrack
class collectd::plugin::conntrack (
  $ensure = present,
) {
  collectd::plugin {'conntrack':
    ensure => $ensure,
  }
}
