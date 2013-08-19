class collectd::plugin::network (
  $server = undef,
  $serverport = 25826,
  $server_securitylevel = 'None',
  $server_username = undef,
  $server_password = undef,
  $server_interface = undef,
  $listen = undef,
  $listenport = 25826,
  $listen_securitylevel = 'None',
  $listen_authfile = undef,
  $listen_interface = undef,
  $timetolive = undef,
  $maxpacketsize = undef,
  $forward = 'false',
  $reportstats = 'false',
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'network.conf':
    ensure  => $collectd::plugin::network::ensure,
    path    => "${conf_dir}/network.conf",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/network.conf.erb'),
    notify  => Service['collectd']
  }
}
