# https://collectd.org/wiki/index.php/Plugin:Interface
class collectd::plugin::interface (
  $ensure                 = 'present',
  Array $interfaces       = [],
  Boolean $ignoreselected = false,
  Boolean $reportinactive = true,
  $interval               = undef,
) {
  include collectd

  collectd::plugin { 'interface':
    ensure   => $ensure,
    content  => template('collectd/plugin/interface.conf.erb'),
    interval => $interval,
  }
}
