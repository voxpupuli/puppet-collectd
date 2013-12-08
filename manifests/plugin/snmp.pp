# https://collectd.org/wiki/index.php/Plugin:SNMP
class collectd::plugin::snmp (
  $ensure = present,
  $data   = undef,
  $hosts  = undef,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  validate_hash($data, $hosts)

  file { 'snmp.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/snmp.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/snmp.conf.erb'),
    notify    => Service['collectd']
  }
}
