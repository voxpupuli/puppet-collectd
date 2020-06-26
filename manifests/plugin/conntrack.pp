# https://collectd.org/wiki/index.php/Plugin:ConnTrack
class collectd::plugin::conntrack (
  Enum['present', 'absent'] $ensure = 'present',
) {
  include collectd

  collectd::plugin { 'conntrack':
    ensure => $ensure,
  }
}
