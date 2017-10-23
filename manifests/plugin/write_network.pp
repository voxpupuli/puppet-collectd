# A define to make a generic network output for collectd
class collectd::plugin::write_network (
  $ensure  = 'present',
  $server = 'localhost',
  $port = '25826',
) {

  include ::collectd

  validate_string($server)
  validate_re($port, '^\d{1,5}$')

  if empty($server) {
    fail('server cannot be empty')
  }

  ::collectd::plugin::network::server {$server :
    ensure => $ensure,
    port   => $port,
  }

}
