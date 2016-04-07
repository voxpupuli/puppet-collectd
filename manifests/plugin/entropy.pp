# https://collectd.org/wiki/index.php/Plugin:Entropy
class collectd::plugin::entropy (
  $ensure = undef
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'entropy':
    ensure   => $ensure_real,
    interval => $interval,
  }
}
