#
define collectd::plugin::network::listener (
  Enum['present', 'absent'] $ensure                         = 'present',
  Optional[Stdlib::Absolutepath] $authfile                  = undef,
  Optional[Stdlib::Port] $port                              = undef,
  Optional[Collectd::Network::SecurityLevel] $securitylevel = undef,
  Optional[String] $interface                               = undef,
) {
  include collectd
  include collectd::plugin::network

  $conf_dir = $collectd::plugin_conf_dir

  file { "${conf_dir}/network-listener-${name}.conf":
    ensure  => $ensure,
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/plugin/network/listener.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
