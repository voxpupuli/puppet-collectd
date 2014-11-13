# https://collectd.org/wiki/index.php/Plugin:IPTables
class collectd::plugin::iptables (
  $ensure   = present,
  $chains   = {},
  $interval = undef,
) {
  validate_hash($chains)

  collectd::plugin {'iptables':
    ensure   => $ensure,
    content  => template('collectd/plugin/iptables.conf.erb'),
    interval => $interval,
  }
}
