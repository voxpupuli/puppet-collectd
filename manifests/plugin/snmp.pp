class collectd::plugin::snmp (
  $data   = undef,
  $hosts  = undef,
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  if ! is_hash($data) or ! is_hash($hosts) {
    fail('Both data and hosts parameters must be hashes')
  }

  file { 'snmp.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/snmp.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/snmp.conf.erb'),
    notify    => Service['collectd']
  }
}
