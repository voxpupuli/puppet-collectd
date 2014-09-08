#
define collectd::plugin::network::server (
  $ensure        = 'present',
  $username      = undef,
  $password      = undef,
  $port          = undef,
  $securitylevel = undef,
  $interface     = undef,
) {
  include collectd::params
  include collectd::plugin::network

  $conf_dir = $collectd::params::plugin_conf_dir

  validate_string($name)

  file { "${conf_dir}/network-server-${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::params::root_group,
    content => template('collectd/plugin/network/server.conf.erb'),
    notify  => Service['collectd'],
  }
}
