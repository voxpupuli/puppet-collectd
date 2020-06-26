# http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_threshold
class collectd::plugin::threshold (
  Enum['present', 'absent']          $ensure   = 'present',
  Array[Collectd::Threshold::Host]   $hosts    = [],
  Optional[Integer]                  $interval = undef,
  Array[Collectd::Threshold::Plugin] $plugins  = [],
  Array[Collectd::Threshold::Type]   $types    = []
) {

  include collectd

  collectd::plugin { 'threshold':
    ensure   => $ensure,
    content  => epp('collectd/plugin/threshold.conf.epp'),
    interval => $interval,
  }
}
