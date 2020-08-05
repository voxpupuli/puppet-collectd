#== Class: collectd::plugin::amqp1
#
# Class to manage amqp1 write plugin for collectd
#
# Documentation:
#   https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_amqp1
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
# [*transport*]
#  Name of the transport.
#  Default to 'metrics'
#
# [*host*]
#  Hostname or IP address of the AMQP 1.0 intermediary.
#  Defaults to the 'localhost'
#
# [*port*]
#  Service name or port number on which the AMQP 1.0 intermediary accepts
#  connections. This argument must be a string, even if the numeric form
#  is used.
#  Defaults to 5672
#
# [*user*]
#  User part of credentials used to authenticate to the AMQP 1.0 intermediary.
#  Defaults to 'guest'
#
# [*password*]
#  Password part of credentials used to authenticate to the AMQP 1.0
#  intermediary.
#  Defaults to 'guest'
#
# [*address*]
#  This option specifies the prefix for the send-to value in the message.
#  Defaults to 'collectd'
#
# [*retry_delay*]
#  When the AMQP1 connection is lost, defines the time in seconds to wait
#  before attempting to reconnect.
#  Defaults to 1
#
# [*send_queue_limit*]
#  Limits the SentQueue to a defined value, helps to keep memory usage low
#  when the write target does not respond.
#
# [*interval*]
#  Interval setting for the plugin
#  Defaults to undef
#
# [*instances*]
#  Hash of Hashes representing Instance blocks in plugin configuration file.
#  Key of outter hash represents instance name. The 'address' value concatenated
#  with the 'name' given will be used as the send-to address for communications
#  over the messaging link. Only following keys on inner hashes are taken into
#  account:
#   - format (string):
#      'Command'|'JSON'|'Graphite'; defines format in which messages are sent
#      to the intermediary
#   - presettle (bool):
#      If set to false (the default), the plugin will wait for a message
#      acknowledgement from the messaging bus before sending the next message.
#      Otherwise the plugin will not wait for a message acknowledgement.
#   - notify (bool):
#      If set to false (the default), the plugin will service the instance
#      write call back as a value list. If set to true the plugin will service
#      the instance as a write notification callback for alert formatting.
#   - store_rates (bool):
#      Determines whether or not COUNTER, DERIVE and ABSOLUTE data sources are
#      converted to a rate (GAUGE value). If set to false (the default),
#      no conversion is performed. Otherwise the conversion is performed using
#      the internal value cache. Please note that currently this option is only
#      used if the 'format' option has been set to 'JSON'.
#   - graphite_prefix (string):
#      A prefix can be added in the metric name when outputting in the
#     'Graphite' format. It's added before the host name.
#   - graphite_postfix (string):
#      A postfix can be added in the metric name when outputting in the
#      'Graphite' format. It's added after the host name.
#   - graphite_escape_char (string):
#      Specify a character to replace dots in the host part of the metric name.
#      In 'Graphite' metric name, dots are used as separators between different
#      metric parts (host, plugin, type). Default is '_'.
#   - graphite_separate_instances (bool):
#      If set to true, the plugin instance and type instance will be
#      in their own path component, for example 'host.cpu.0.cpu.idle'. If set
#      to false (the default), the plugin and plugin instance (and likewise
#      the type and type instance) are put into one component, for example
#      'host.cpu-0.cpu-idle'.
#   - graphite_always_append_ds (bool):
#      If set to true, append the name of the data Source> (DS) to the 'metric'
#      identifier. If set to false (the default), this is only done when there
#      is more than one DS.
#   - graphite_preserve_separator (bool):
#      If set to false (the default) the dot character is replaced with
#      GraphiteEscapeChar. Otherwise, if set to true, the dot character is
#      preserved, i.e. passed through.
#
class collectd::plugin::amqp1 (
  Enum['present', 'absent'] $ensure      = 'present',
  Boolean $manage_package                = $collectd::manage_package,
  String $transport                      = 'metrics',
  Stdlib::Host $host                     = 'localhost',
  Stdlib::Port $port                     = 5672,
  String $user                           = 'guest',
  String $password                       = 'guest',
  String $address                        = 'collectd',
  Hash $instances                        = {},
  Optional[Integer] $retry_delay         = undef,
  Optional[Integer[0]] $send_queue_limit = undef,
  Optional[Integer] $interval            = undef,
) {
  include collectd

  if $facts['os']['family'] == 'RedHat' {
    if $manage_package {
      package { 'collectd-amqp1':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'amqp1':
    ensure   => $ensure,
    content  => epp('collectd/plugin/amqp1.conf.epp'),
    interval => $interval,
  }
}
