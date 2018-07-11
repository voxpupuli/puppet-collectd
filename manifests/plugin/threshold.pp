# http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_threshold
class collectd::plugin::threshold (
  $ensure   = 'present',
  $interval = undef,
  Hash[String, Collectd::Threshold::Type]   $types   = {},
  Hash[String, Collectd::Threshold::Plugin] $plugins = {},
  Hash[String, Collectd::Threshold::Host]   $hosts   = {},
) {

  include ::collectd

  collectd::plugin { 'threshold':
    ensure   => $ensure,
    content  => epp('collectd/plugin/threshold.conf.epp'),
    interval => $interval,
  }
}
