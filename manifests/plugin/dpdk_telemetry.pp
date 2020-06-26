# Class to manage dpdk_telemetry plugin for collectd.
#
# The dpdk_telemetry plugin collects DPDK ethernet device metrics via
# dpdk_telemetry library.
#
# Plugin retrieves metrics from a DPDK packet forwarding application
# by sending the JSON formatted message via a UNIX domain socket.
# DPDK telemetry component will respond with a JSON formatted reply
# delivering the requested metrics. Plugin parses the JSON data
# and publishes the metric values to collectd for further use.
#
# @param ensure Ensure param for collectd::plugin type.
# @param client_socket_path UNIX domain client socket to receive messages from DPDK telemetry library.
# @param dpdk_socket_path UNIX domain DPDK telemetry socket to be connected to send messages.
#
class collectd::plugin::dpdk_telemetry (
  Enum['present', 'absent'] $ensure             = 'present',
  Stdlib::Absolutepath      $client_socket_path = '/var/run/.client',
  Stdlib::Absolutepath      $dpdk_socket_path   = '/var/run/dpdk/rte/telemetry',
) {
  include collectd

  collectd::plugin { 'dpdk_telemetry':
    ensure  => $ensure,
    content => epp('collectd/plugin/dpdk_telemetry.conf.epp'),
  }
}
