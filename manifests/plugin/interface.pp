# https://collectd.org/wiki/index.php/Plugin:Interface
class collectd::plugin::interface (
  $ensure         = 'present',
  $interfaces     = [],
  $ignoreselected = false,
  $reportinactive = true,
  $interval       = undef,
) {

  include ::collectd

  validate_array($interfaces)
  validate_bool(
    $ignoreselected,
    $reportinactive,
  )

  collectd::plugin { 'interface':
    ensure   => $ensure,
    content  => template('collectd/plugin/interface.conf.erb'),
    interval => $interval,
  }
}
