# https://collectd.org/wiki/index.php/Plugin:Load
class collectd::plugin::load (
  $ensure   = 'present',
  $interval = undef,
  $report_relative = false,
) {
  include collectd

  collectd::plugin { 'load':
    ensure   => $ensure,
    content  => template('collectd/plugin/load.conf.erb'),
    interval => $interval,
  }
}
