#== Class: collectd::plugin::hugepages
#
# Class to manage hugepages write plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_hugepages
#
# === Parameters
#
# [*ensure*]
#  Ensure param for collectd::plugin type.
#  Defaults to 'ensure'
#
# [*interval*]
#  Interval setting for the plugin
#  Defaults to undef
#
# [*report_per_node_hp*]
#  If enabled, information will be collected from the hugepage counters in
#  "/sys/devices/system/node/*/hugepages". This is used to check the per-node
#  hugepage statistics on a NUMA system.
#  Defaults to true
#
# [*report_root_hp*]
#  If enabled, information will be collected from the hugepage counters in
#  "/sys/kernel/mm/hugepages". This can be used on both NUMA and non-NUMA
#  systems to check the overall hugepage statistics.
#  Defaults to true
#
# [*values_pages*]
#  Whether to report hugepages metrics in number of pages
#  Defaults to true
#
# [*values_bytes*]
#  Whether to report hugepages metrics in bytes
#  Defaults to false
#
# [*values_percentage*]
#  Whether to report hugepages metrics in percentage
#  Defaults to false
#
class collectd::plugin::hugepages (
  Enum['present', 'absent'] $ensure   = 'present',
  Optional[Integer] $interval         = undef,
  Boolean $report_per_node_hp         = true,
  Boolean $report_root_hp             = true,
  Boolean $values_pages               = true,
  Boolean $values_bytes               = false,
  Boolean $values_percentage          = false,
) {
  include collectd

  collectd::plugin { 'hugepages':
    ensure   => $ensure,
    interval => $interval,
    content  => epp('collectd/plugin/hugepages.conf.epp'),
  }
}
