# https://collectd.org/wiki/index.php/Plugin:Load
class collectd::plugin::load (
  $ensure = undef
  $interval = undef,
  $report_relative = false,
) {

  include ::collectd

  collectd::plugin { 'load':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/load.conf.erb'),
    interval => $interval,
  }
}
