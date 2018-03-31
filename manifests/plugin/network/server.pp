#
define collectd::plugin::network::server (
  $ensure          = 'present',
  $username        = undef,
  $password        = undef,
  $port            = undef,
  $securitylevel   = undef,
  $interface       = undef,
  $forward         = undef,
  $resolveinterval = undef,
) {

  include ::collectd
  include ::collectd::plugin::network

  $conf_dir = $::collectd::plugin_conf_dir

  file { "${conf_dir}/network-server-${name}.conf":
    ensure  => $ensure,
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/plugin/network/server.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
