# https://collectd.org/wiki/index.php/Plugin:thermal
class collectd::plugin::thermal (
  $devices        = [],
  $ensure         = 'present',
  $ignoreselected = false,
  $interval       = undef,
) {

  include ::collectd

  validate_array($devices)
  validate_bool($ignoreselected)

  collectd::plugin { 'thermal':
    ensure   => $ensure,
    content  => template('collectd/plugin/thermal.conf.erb'),
    interval => $interval,
  }
}
