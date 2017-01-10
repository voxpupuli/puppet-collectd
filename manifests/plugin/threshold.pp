# http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_threshold
class collectd::plugin::threshold (
  $ensure            = 'present',
  $order             = 10,
  $interval          = undef,
  $threshold_types   = { },
  $threshold_hosts   = { },
  $threshold_plugins = { },
) {

  include ::collectd

  validate_hash($threshold_types)
  validate_hash($threshold_hosts)
  validate_hash($threshold_plugins)

  collectd::plugin { 'threshold':
    ensure   => $ensure,
    order    => $order,
    interval => $interval,
  }

  $defaults = { 'ensure' => $ensure }

  if $threshold_types {
    create_resources(
      collectd::plugin::threshold::threshold_type,
      $threshold_types,
      $defaults
    )
  }
  if $threshold_plugins {
    create_resources(
      collectd::plugin::threshold::threshold_plugin,
      $threshold_plugins,
      $defaults
    )
  }
  if $threshold_hosts {
    create_resources(
      collectd::plugin::threshold::threshold_host,
      $threshold_hosts,
      $defaults
    )
  }
}
