#== Class: collectd::plugin::procevent
#
# Class to manage procevent plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_procevent
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
# [*process*]
#  Enumerate a process name to monitor.  All processes that match this exact
#  name will be monitored for EXECs and EXITs.
#  Defaults to undef
#
# [*process_regex*]
#  Enumerate a process pattern to monitor.  All processes that match this
#  regular expression will be monitored for EXECs and EXITs.
#  Defaults to undef
#
# [*buffer_length*]
#  Maximum number of rsyslog events that can be stored in plugin's ring buffer.
#  Once an event has been read, its location becomes available for storing
#  a new event.
#  Defaults to undef
#
class collectd::plugin::procevent (
  Enum['present', 'absent'] $ensure            = 'present',
  Boolean $manage_package                      = $collectd::manage_package,
  Optional[String[1]] $process                 = undef,
  Optional[String[1]] $process_regex           = undef,
  Optional[Integer[1, default]] $buffer_length = undef,
) {
  include collectd

  if $manage_package and $facts['os']['family'] == 'RedHat' {
    package { 'collectd-procevent':
      ensure => $ensure,
    }
  }

  collectd::plugin { 'procevent':
    ensure  => $ensure,
    content => epp('collectd/plugin/procevent.conf.epp'),
  }
}
