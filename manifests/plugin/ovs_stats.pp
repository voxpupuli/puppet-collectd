#== Class: collectd::plugin::ovs_stats
#
# Class to manage ovs_stats plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ovs_stats
#
# === Parameters
#
# [* address *]
#  The address of the OVS DB server JSON-RPC interface used by the plugin.
#
# [* bridges *]
#  List of OVS bridge names to be monitored by this plugin. If this option
#  is omitted or is empty then all OVS bridges will be monitored
#
# [*ensure*]
#  ensure param for collectd::plugin type.
#  Defaults to 'ensure'
#
# [*manage_package*]
#  If enabled, manages separate package for plugin
#  Defaults to true
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
class collectd::plugin::ovs_stats (
  Optional[String] $address = undef,
  Optional[Array] $bridges  = undef,
  String $ensure            = 'present',
  Boolean $manage_package   = true,
  String $package_name      = 'collectd-ovs-stats',
  Optional[Stdlib::Port] $port = undef,
  Optional[String] $socket  = undef,
) {
  include collectd

  if $manage_package {
    package { 'collectd-ovs-stats':
      ensure => $ensure,
      name   => $package_name,
    }
  }

  collectd::plugin { 'ovs_stats':
    ensure  => $ensure,
    content => template('collectd/plugin/ovs_stats.conf.erb'),
  }
}
