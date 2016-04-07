# https://collectd.org/wiki/index.php/Plugin:ContextSwitch
class collectd::plugin::contextswitch (
  $ensure   = 'present',
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'contextswitch':
    ensure   => $ensure,
    interval => $interval,
  }
}
