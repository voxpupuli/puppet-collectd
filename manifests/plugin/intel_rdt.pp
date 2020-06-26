#== Class: collectd::plugin::intel_rdt
#
# Class to manage intel_rdt write plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_intel_rdt
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
# [*cores*]
#  All events are reported on a per core basis. Monitoring of the events can be
#  configured for group of cores (aggregated statistics). This field defines
#  groups of cores on which to monitor supported events. The field is
#  represented as list of strings with core group values. Each string
#  represents a list of cores in a group. Allowed formats are: 0,1,2,3
#  0-10,20-18 1,3,5-8,10,0x10-12
#  If an empty string is provided as value for this field default cores
#  configuration is applied - a separate group is created for each core.
#  Defaults to ""
#
class collectd::plugin::intel_rdt (
  Enum['present', 'absent'] $ensure   = 'present',
  Optional[Integer] $interval         = undef,
  Array[String[1]] $cores             = [],
) {
  include collectd

  collectd::plugin { 'intel_rdt':
    ensure   => $ensure,
    interval => $interval,
    content  => epp('collectd/plugin/intel_rdt.conf.epp'),
  }
}
