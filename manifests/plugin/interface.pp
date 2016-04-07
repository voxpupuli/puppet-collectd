# https://collectd.org/wiki/index.php/Plugin:Interface
class collectd::plugin::interface (
  $ensure = undef
  $interfaces     = [],
  $ignoreselected = false,
  $interval       = undef,
) {

  include ::collectd

  validate_array($interfaces)
  validate_bool($ignoreselected)

  collectd::plugin { 'interface':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/interface.conf.erb'),
    interval => $interval,
  }
}
