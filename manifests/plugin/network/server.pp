#
define collectd::plugin::network::server (
  $ensure = undef
  $username      = undef,
  $password      = undef,
  $port          = undef,
  $securitylevel = undef,
  $interface     = undef,
  $forward       = undef,
) {

  include ::collectd
  include ::collectd::plugin::network

  $conf_dir = $::collectd::plugin_conf_dir

  validate_string($name)

  file { "${conf_dir}/network-server-${name}.conf":
    ensure  => $ensure_real,
    mode    => '0640',
    owner   => 'root',
    group   => $::collectd::root_group,
    content => template('collectd/plugin/network/server.conf.erb'),
    notify  => Service['collectd'],
  }
}
