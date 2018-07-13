# http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_threshold
class collectd::plugin::threshold (
  $ensure   = 'present',
  $interval = undef,
  Array[Collectd::Threshold::Type]   $types   = [],
  Array[Collectd::Threshold::Plugin] $plugins = [],
  Array[Collectd::Threshold::Host]   $hosts   = [],
) {

  include ::collectd

  collectd::plugin { 'threshold':
    ensure   => $ensure,
    content  => epp('collectd/plugin/threshold.conf.epp'),
    interval => $interval,
  }
}
