# https://collectd.org/wiki/index.php/Plugin:ContextSwitch
class collectd::plugin::contextswitch (
  Enum['present', 'absent'] $ensure   = 'present',
  Optional[Integer[1]] $interval      = undef,
) {
  include collectd

  collectd::plugin { 'contextswitch':
    ensure   => $ensure,
    interval => $interval,
  }
}
