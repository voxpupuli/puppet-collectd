#== Class: collectd::plugin::ipc
#
# Class to manage ipc write plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ipc
#
# === Parameters
#
# [*ensure*]
#  Ensure param for collectd::plugin type.
#  Defaults to 'ensure'
#
class collectd::plugin::ipc (
  Enum['present', 'absent'] $ensure   = 'present',
) {
  include collectd

  collectd::plugin { 'ipc':
    ensure   => $ensure,
  }
}
