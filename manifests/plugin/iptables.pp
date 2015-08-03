# https://collectd.org/wiki/index.php/Plugin:IPTables
class collectd::plugin::iptables (
  $ensure   = present,
  $ensure_package = present,
  $chains   = {},
  $interval = undef,
) {
  validate_hash($chains)

  if $::osfamily == 'Redhat' {
    package { 'collectd-iptables':
      ensure => $ensure_package,
    }
  }

  collectd::plugin {'iptables':
    ensure   => $ensure,
    content  => template('collectd/plugin/iptables.conf.erb'),
    interval => $interval,
  }
}
