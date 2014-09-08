#
define collectd::plugin::network::listener (
  $ensure        = 'present',
  $authfile      = undef,
  $port          = undef,
  $securitylevel = undef,
  $interface     = undef,
) {
  include collectd::params
  include collectd::plugin::network

  $conf_dir = $collectd::params::plugin_conf_dir

  validate_string($name)

  file { "${conf_dir}/network-listener-${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::params::root_group,
    content => template('collectd/plugin/network/listener.conf.erb'),
    notify  => Service['collectd'],
  }
}
