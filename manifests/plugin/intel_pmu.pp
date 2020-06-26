# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_intel_pmu
class collectd::plugin::intel_pmu (
  Enum['present', 'absent'] $ensure                       = 'present',
  Optional[Boolean]         $report_hardware_cache_events = false,
  Optional[Boolean]         $report_kernel_pmu_events     = false,
  Optional[Boolean]         $report_software_events       = false,
  Optional[String]          $event_list                   = undef,
  Optional[Array[String]]   $hardware_events              = undef,
) {
  include collectd

  if $hardware_events and $event_list == undef {
    fail('event_list must be defined if hardware_events is used.')
  }

  collectd::plugin { 'intel_pmu':
    ensure  => $ensure,
    content => template('collectd/plugin/intel_pmu.conf.erb'),
  }
}
