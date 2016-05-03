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

  validate_string($name)

  file { "${conf_dir}/network-server-${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $::collectd::root_group,
    content => template('collectd/plugin/network/server.conf.erb'),
    notify  => Service['collectd'],
  }
}
