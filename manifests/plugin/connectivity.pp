#== Class: collectd::plugin::connectivity
#
# Class to manage connectivity plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_connectivity
#
# === Parameters
#
# [*ensure*]
#  Ensure param for collectd::plugin type.
#  Defaults to 'ensure'
#
# [*manage_package*]
#  Set to true if Puppet should manage plugin package installation.
#  Defaults to $collectd::manage_package
#
# [*interfaces*]
#  Array of interface(s) to monitor connect to. Empty arrayf means all interfaces
#  Defaults to []
#
class collectd::plugin::connectivity (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $manage_package           = $collectd::manage_package,
  Array[String[1]] $interfaces      = [],
) {
  include collectd

  if $manage_package and $facts['os']['family'] == 'RedHat' {
    package { 'collectd-connectivity':
      ensure => $ensure,
    }
  }

  collectd::plugin { 'connectivity':
    ensure  => $ensure,
    content => epp('collectd/plugin/connectivity.conf.epp'),
  }
}
