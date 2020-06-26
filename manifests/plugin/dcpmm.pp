# Class to manage dcpmm plugin for collectd.
#
# The dcpmm plugin will collect Intel(R) Optane(TM) DC Persistent Memory related performance statistics.
# Plugin requires root privileges to perform the statistics collection.
#
# @param ensure Ensure param for collectd::plugin type.
# @param interval Sets interval (in seconds) in which the values will be collected.
# @param collect_health Collects health information. collect_health and collect_perf_metrics cannot be true at the same time.
# @param collect_perf_metrics Collects memory performance metrics. collect_health and collect_perf_metrics cannot be true at the same time.
# @param enable_dispatch_all This parameter helps to seamlessly enable simultaneous health and memory perf metrics collection in future. Unused at the moment and must always be false.
#
class collectd::plugin::dcpmm (
  Enum['present', 'absent'] $ensure               = 'present',
  Float                     $interval             = 10.0,
  Boolean                   $collect_health       = false,
  Boolean                   $collect_perf_metrics = true,
  Boolean                   $enable_dispatch_all  = false,

) {
  include collectd

  if $collect_health and $collect_perf_metrics {
    fail('collect_health and collect_perf_metrics cannot be true at the same time.')
  }

  if $enable_dispatch_all {
    fail('enable_dispatch_all is unused at the moment and must always be false.')
  }

  collectd::plugin { 'dcpmm':
    ensure  => $ensure,
    content => epp('collectd/plugin/dcpmm.conf.epp'),
  }
}
