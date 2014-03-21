# https://collectd.org/wiki/index.php/Plugin:ContextSwitch
class collectd::plugin::contextswitch (
  $ensure = present,
) {
  collectd::plugin {'contextswitch':
    ensure => $ensure
  }
}
