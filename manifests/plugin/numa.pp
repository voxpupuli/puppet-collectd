#== Class: collectd::plugin::numa
#
# Class to manage numa write plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_numa
#
# === Parameters
#
# [*ensure*]
#  Ensure param for collectd::plugin type.
#  Defaults to 'ensure'
#
class collectd::plugin::numa (
  Enum['present', 'absent'] $ensure   = 'present',
) {
  include collectd

  collectd::plugin { 'numa':
    ensure   => $ensure,
  }
}
