# https://collectd.org/wiki/index.php/Plugin:SNMP
define collectd::plugin::snmp::host (
  Variant[String[1], Array[String[1], 1]]   $collect,
  Enum['present', 'absent']                 $ensure             = 'present',
  String[1]                                 $address            = $name,
  Collectd::SNMP::Version                   $version            = '1',
  Optional[Integer[0]]                      $interval           = undef,
  # SNMPv1/2c
  Optional[String[1]]                       $community          = 'public',
  # SNMPv3
  Optional[String[1]]                       $username           = undef,
  Optional[Collectd::SNMP::SecurityLevel]   $security_level     = undef,
  Optional[String[1]]                       $context            = undef,
  Optional[Collectd::SNMP::AuthProtocol]    $auth_protocol      = undef,
  Optional[String[1]]                       $auth_passphrase    = undef,
  Optional[Collectd::SNMP::PrivacyProtocol] $privacy_protocol   = undef,
  Optional[String[1]]                       $privacy_passphrase = undef,
) {
  include collectd
  include collectd::plugin::snmp

  $conf_dir   = $collectd::plugin_conf_dir

  file { "snmp-host-${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/25-snmp-host-${name}.conf",
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => template('collectd/plugin/snmp/host.conf.erb'),
    notify  => Service[$collectd::service_name];
  }
}
