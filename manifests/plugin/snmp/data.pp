# https://collectd.org/wiki/index.php/Plugin:SNMP
define collectd::plugin::snmp::data (
  $instance,
  $type,
  $values,
  $ensure = present,
  $table = false,
) {
  include collectd
  include collectd::plugin::snmp

  $table_bool = str2bool($table)

  $conf_dir = $collectd::params::plugin_conf_dir

  file { "snmp-data-${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/15-snmp-data-${name}.conf",
    owner   => $collectd::root_user,
    group   => $collectd::root_group,
    mode    => '0640',
    content => template('collectd/plugin/snmp/data.conf.erb'),
    notify  => Service['collectd'];
  }
}
