# https://collectd.org/wiki/index.php/Plugin:ConnTrack
class collectd::plugin::conntrack (
  $ensure = undef
) {

  include ::collectd

  collectd::plugin { 'conntrack':
    ensure => $ensure_real,
  }
}
