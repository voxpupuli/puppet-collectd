# https://collectd.org/wiki/index.php/Plugin:SNMP
class collectd::plugin::snmp (
  $ensure = present,
  $data   = undef,
  $hosts  = undef,
) {
  validate_hash($data, $hosts)

  collectd::plugin {'snmp':
    ensure  => $ensure,
    content => template('collectd/plugin/snmp.conf.erb'),
  }
}
