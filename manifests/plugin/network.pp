# https://collectd.org/wiki/index.php/Plugin:Network
class collectd::plugin::network (
  $ensure               = present,
  $forward              = false,
  $listen               = undef,
  $listen_authfile      = undef,
  $listen_interface     = undef,
  $listen_securitylevel = 'None',
  $listenport           = 25826,
  $maxpacketsize        = undef,
  $reportstats          = false,
  $server               = undef,
  $server_interface     = undef,
  $server_password      = undef,
  $server_securitylevel = 'None',
  $server_username      = undef,
  $serverport           = 25826,
  $timetolive           = undef,
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
