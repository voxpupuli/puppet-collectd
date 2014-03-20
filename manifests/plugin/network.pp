# https://collectd.org/wiki/index.php/Plugin:Network
class collectd::plugin::network (
  $ensure               = present,
  $timetolive           = undef,
  $maxpacketsize        = undef,
  $forward              = false,
  $reportstats          = false,
  $listen               = undef,
  $listen_authfile      = undef,
  $listen_interface     = undef,
  $listen_securitylevel = 'None',
  $listenport           = 25826,
  $server               = undef,
  $server_interface     = undef,
  $server_password      = undef,
  $server_securitylevel = 'None',
  $server_username      = undef,
  $serverport           = 25826,
) {
  validate_bool(
    $forward,
    $reportstats,
  )

  collectd::plugin {'network':
    ensure  => $ensure,
    content => template('collectd/plugin/network.conf.erb'),
  }
}
