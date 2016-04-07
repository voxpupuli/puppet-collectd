#
define collectd::plugin::network::listener (
  $ensure = undef
  $authfile      = undef,
  $port          = undef,
  $securitylevel = undef,
  $interface     = undef,
) {

  include ::collectd
  include ::collectd::plugin::network

  $conf_dir = $collectd::plugin_conf_dir

  validate_string($name)

  file { "${conf_dir}/network-listener-${name}.conf":
    ensure  => $ensure_real,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/plugin/network/listener.conf.erb'),
    notify  => Service['collectd'],
  }
}
