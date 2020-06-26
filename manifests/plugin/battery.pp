#== Class: collectd::plugin::battery
#
# Class to manage battery write plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_battery
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
# [*values_percentage*]
#  When enabled, remaining capacity is reported as a percentage instead of raw
#  data (most likely in "Wh")
#  Defaults to false
#
# [*report_degraded*]
#  When set to true, the battery plugin will report three values: charged
#  (remaining capacity), discharged (difference between "last full capacity"
#  and "remaining capacity") and degraded (difference between "design capacity"
#  and "last full capacity"). Otherwise only the remaining capacity is
#  reported.
#  Defaults to false
#
# [*query_state_fs*]
#  When set to true, the battery plugin will only read statistics related to
#  battery performance as exposed by StateFS at /run/state.
#  Defaults to false
#
class collectd::plugin::battery (
  Enum['present', 'absent'] $ensure   = 'present',
  Optional[Integer] $interval         = undef,
  Boolean $values_percentage          = false,
  Boolean $report_degraded            = false,
  Boolean $query_state_fs             = false,
) {
  include collectd

  collectd::plugin { 'battery':
    ensure   => $ensure,
    interval => $interval,
    content  => epp('collectd/plugin/battery.conf.epp'),
  }
}
