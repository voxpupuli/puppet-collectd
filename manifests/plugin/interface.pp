# https://collectd.org/wiki/index.php/Plugin:Interface
class collectd::plugin::interface (
  $ensure                 = 'present',
  Boolean $ignoreselected = false,
  Array $interfaces       = [],
  $interval               = undef,
  Boolean $reportinactive = true
) {

  include collectd

  collectd::plugin { 'interface':
    ensure   => $ensure,
    content  => template('collectd/plugin/interface.conf.erb'),
    interval => $interval,
  }
}
