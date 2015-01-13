# https://collectd.org/wiki/index.php/Plugin:SNMP
define collectd::plugin::snmp::data (
  $ensure = present,
  $type,
  $table = false,
  $instance,
  $values,
) {
  include collectd
  include collectd::plugin::snmp

  $table_bool = str2bool($table)

  $conf_dir = $collectd::params::plugin_conf_dir
  $root_group = $collectd::params::root_group

  file { "snmp-data-${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/15-snmp-data-${name}.conf",
    owner   => 'root',
    group   => $root_group,
    mode    => '0640',
    content => template('collectd/plugin/snmp/data.conf.erb'),
    notify  => Service['collectd'];
  }
}
