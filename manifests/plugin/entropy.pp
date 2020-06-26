# https://collectd.org/wiki/index.php/Plugin:Entropy
class collectd::plugin::entropy (
  $ensure   = 'present',
  $interval = undef,
) {
  include collectd

  collectd::plugin { 'entropy':
    ensure   => $ensure,
    interval => $interval,
  }
}
