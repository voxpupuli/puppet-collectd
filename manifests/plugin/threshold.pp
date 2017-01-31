# http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_threshold
class collectd::plugin::threshold (
  $ensure   = 'present',
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'threshold':
    ensure   => $ensure,
    interval => $interval,
  }
}
