# https://collectd.org/wiki/index.php/Plugin:Entropy
class collectd::plugin::entropy (
  $ensure = present,
) {

  collectd::plugin {'entropy':
    ensure  => $ensure,
  }
}
