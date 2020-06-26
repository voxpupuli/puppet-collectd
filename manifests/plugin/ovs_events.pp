#== Class: collectd::plugin::ovs_events
#
# Class to manage ovs_events plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ovs_events
#
# === Parameters
#
# [* address *]
#  The address of the OVS DB server JSON-RPC interface used by the plugin.
#
# [*dispatch*]
#  Dispatch the OVS DB interface link status value with configured plugin
#  interval.
#
# [*ensure*]
#  ensure param for collectd::plugin type.
#  Defaults to 'ensure'
#
# [* interfaces *]
#  List of interface names to be monitored by this plugin. If this option
#  is not specified or is empty then all OVS connected interfaces
#  on all bridges are monitored.
#
# [*manage_package*]
#  If enabled, manages separate package for plugin
#  Defaults to true
#
# [*send_notification*]
#  If set to true, OVS link notifications (interface status and
#  OVS DB connection terminate) are sent to collectd.
#
# [*package_name*]
#  If manage_package is true, this gives the name of the package to manage.
#  Defaults to 'collectd-ovs_stats'
#
# [*port*]
#  TCP-port to connect to.
#
# [*socket*]
#  The UNIX domain socket path of OVS DB server JSON-RPC interface used
#  by the plugin
#
class collectd::plugin::ovs_events (
  Optional[Stdlib::Host] $address      = undef,
  Optional[Boolean] $dispatch          = undef,
  String $ensure                       = 'present',
  Optional[Array] $interfaces          = [],
  Boolean $manage_package              = true,
  Optional[Boolean] $send_notification = undef,
  String $package_name                 = 'collectd-ovs-events',
  Optional[Stdlib::Port] $port         = undef,
  Optional[String] $socket             = undef,
) {
  include collectd

  if $manage_package {
    package { 'collectd-ovs-events':
      ensure => $ensure,
      name   => $package_name,
    }
  }

  collectd::plugin { 'ovs_events':
    ensure  => $ensure,
    content => template('collectd/plugin/ovs_events.conf.erb'),
  }
}
