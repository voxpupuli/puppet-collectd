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
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_bool(
    $forward,
    $reportstats,
  )

  file { 'network.conf':
    ensure  => $collectd::plugin::network::ensure,
    path    => "${conf_dir}/network.conf",
    mode    => '0644',
    owner   => 'root',
    group   => $collectd::params::root_group,
    content => template('collectd/network.conf.erb'),
    notify  => Service['collectd']
  }
}
