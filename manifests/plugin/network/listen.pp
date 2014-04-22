define collectd::plugin::network::listen (
  $ensure        = 'present',
  $authfile      = undef,
  $interface     = undef,
  $server          = $name,
  $securitylevel = 'None',
  $port          = 25826,
) {
  include collectd::params
  include collectd::plugin::network

  $conf_dir = $collectd::params::plugin_conf_dir
  if $authfile  {
    validate_string($authfile)
  }
  if $interface {
    validate_string($interface)
  }
  validate_string($server)
  validate_re($port, '[0-9]+')
  validate_re($securitylevel, '(Encrypt|Sign|None)')

  file { "network-listen-${name}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/network-listen-${name}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/network-listen.conf.erb'),
    notify    => Service['collectd'],
  }
}

