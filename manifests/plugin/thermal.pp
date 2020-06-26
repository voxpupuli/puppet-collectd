# https://collectd.org/wiki/index.php/Plugin:thermal
class collectd::plugin::thermal (
  Array $devices          = [],
  $ensure                 = 'present',
  Boolean $ignoreselected = false,
  $interval               = undef,
) {
  include collectd

  collectd::plugin { 'thermal':
    ensure   => $ensure,
    content  => template('collectd/plugin/thermal.conf.erb'),
    interval => $interval,
  }
}
