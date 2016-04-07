# https://collectd.org/wiki/index.php/Plugin:ContextSwitch
class collectd::plugin::contextswitch (
  $ensure = undef
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'contextswitch':
    ensure   => $ensure_real,
    interval => $interval,
  }
}
