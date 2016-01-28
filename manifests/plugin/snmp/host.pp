# https://collectd.org/wiki/index.php/Plugin:SNMP
define collectd::plugin::snmp::host (
  $collect,
  $ensure = present,
  $address = $name,
  $version = '1',
  $community = 'public',
  $interval = undef,
) {
  include ::collectd
  include ::collectd::plugin::snmp

  validate_re($version, '^[12]$', 'only snmp versions 1 and 2 are supported')

  $conf_dir = $collectd::params::plugin_conf_dir
  $root_group = $collectd::params::root_group

  file { "snmp-host-${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/25-snmp-host-${name}.conf",
    owner   => 'root',
    group   => $root_group,
    mode    => '0640',
    content => template('collectd/plugin/snmp/host.conf.erb'),
    notify  => Service['collectd'];
  }
}
