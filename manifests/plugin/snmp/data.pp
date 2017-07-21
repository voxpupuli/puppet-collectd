# https://collectd.org/wiki/index.php/Plugin:SNMP
define collectd::plugin::snmp::data (
  String                                            $instance,
  String[1]                                         $type,
  Variant[String[1], Array[String[1], 1]]           $values,
  Enum['present', 'absent']                         $ensure          = 'present',
  Optional[String[1]]                               $instance_prefix = undef,
  Optional[Numeric]                                 $scale           = undef,
  Optional[Numeric]                                 $shift           = undef,
  Boolean                                           $table           = false,
  Optional[Variant[String[1], Array[String[1], 1]]] $ignore          = undef,
  Boolean                                           $invert_match    = false,
) {

  include ::collectd
  include ::collectd::plugin::snmp

  $conf_dir   = $collectd::plugin_conf_dir
  $root_group = $collectd::root_group

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
