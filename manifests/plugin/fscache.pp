# https://collectd.org/wiki/index.php/Plugin:FSCache
class collectd::plugin::fscache (
  $ensure = 'present',
) {
  include collectd

  collectd::plugin { 'fscache':
    ensure => $ensure,
  }
}
