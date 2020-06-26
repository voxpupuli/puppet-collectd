# https://collectd.org/wiki/index.php/Plugin:Nut
class collectd::plugin::nut (
  $ensure        = 'present',
  $upss       = {},
) {
  include collectd

  collectd::plugin { 'nut':
    ensure   => $ensure,
  }
  $upss.each |String $ups| {
    collectd::plugin::nut::ups { $upss:
      ensure => $ensure,
    }
  }
}
