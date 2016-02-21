# https://collectd.org/wiki/index.php/Plugin:Load
class collectd::plugin::load (
  $ensure   = 'present',
  $interval = undef,
  $report_relative = undef,
) {

  include ::collectd

  collectd::plugin { 'load':
    ensure   => $ensure,
    interval => $interval,
  }
}
