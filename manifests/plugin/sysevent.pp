#== Class: collectd::plugin::sysevent
#
# Class to manage sysevent plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_sysevent
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
# [*listen_host*]
#  Listen on this IP for incoming rsyslog messages.
#  Defaults to '127.0.0.1'
#
# [*listen_port*]
#  Listen on this port for incoming rsyslog messages.
#  Defaults to 6666
#
# [*regex_filter*]
#  Enumerate a regex filter to apply to all incoming rsyslog messages.  If a
#  message matches this filter, it will be published.
#  Defaults to '.*'
#
# [*buffer_size*]
#  Maximum allowed size for incoming rsyslog messages.  Messages that exceed
#  this number will be truncated to this size.  Default is 4096 bytes.
#  Defaults to undef
#
# [*buffer_length*]
#  Maximum number of rsyslog events that can be stored in plugin's ring buffer.
#  Once an event has been read, its location becomes available for storing
#  a new event.
#  Defaults to undef
#
class collectd::plugin::sysevent (
  Enum['present', 'absent'] $ensure            = 'present',
  Boolean $manage_package                      = $collectd::manage_package,
  Stdlib::Host $listen_host                    = '127.0.0.1',
  Stdlib::Port $listen_port                    = 6666,
  String $regex_filter                         = '/.*/',
  Optional[Integer[0]] $buffer_size            = undef,
  Optional[Integer[1, default]] $buffer_length = undef,
) {
  include collectd

  if $manage_package and $facts['os']['family'] == 'RedHat' {
    package { 'collectd-sysevent':
      ensure => $ensure,
    }
  }

  collectd::plugin { 'sysevent':
    ensure  => $ensure,
    content => epp('collectd/plugin/sysevent.conf.epp'),
  }
}
