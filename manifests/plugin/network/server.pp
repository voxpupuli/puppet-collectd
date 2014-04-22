define collectd::plugin::network::server (
  $ensure        = 'present',
  $server        = $name,
  $interface     = undef,
  $password      = undef,
  $securitylevel = 'None',
  $username      = undef,
  $port    = 25826,
) {
  include collectd::params
  include collectd::plugin::network

  $conf_dir = $collectd::params::plugin_conf_dir

  validate_string($server)
  if $interface {
    validate_string($interface)
  }
  if $password or $username {
    validate_string($password, $username)
  }
  validate_re($securitylevel, '(Encrypt|Sign|None)')
  validate_re($port, '[0-9]+')

  file { "network-server-${name}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/network-server-${name}.conf",
    mode      => '0640', # hey there's a password in here !
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/network-server.conf.erb'),
    notify    => Service['collectd'],
  }
}

