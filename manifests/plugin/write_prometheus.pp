# Class: collectd::plugin::write_prometheus
#
# @see https://collectd.org/wiki/index.php/Plugin:Write_Prometheus

# Configures write_prometheus plugin.
#
# @param port Stdlib::Port Defines the port on which to accept scrape requests from Prometheus. Default: 9103
# @param ip Optional[Stdlib::IP::Address] Defines the IP address to bind to. In not specified, the listener will bind to all IPs present.
class collectd::plugin::write_prometheus (
  Stdlib::Port $port = 9103,
  Optional[Stdlib::IP::Address] $ip = undef,
  $ensure = 'present',
) {
  include collectd

  collectd::plugin { 'write_prometheus':
    ensure  => $ensure,
    content => template('collectd/plugin/write_prometheus.conf.erb'),
  }
}
