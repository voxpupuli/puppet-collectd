#
define collectd::plugin::network::listener (
  $ensure        = 'present',
  $authfile      = undef,
  $port          = undef,
  $securitylevel = undef,
  $interface     = undef,
) {

  include ::collectd
  include ::collectd::plugin::network

  $conf_dir = $collectd::plugin_conf_dir

  file { "${conf_dir}/network-listener-${name}.conf":
    ensure  => $ensure,
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/plugin/network/listener.conf.erb'),
    notify  => Service['collectd'],
  }
}
