# https://collectd.org/wiki/index.php/Plugin:IPTables
class collectd::plugin::iptables (
  $ensure         = present,
  $ensure_package = present,
  $manage_package = $collectd::manage_package,
  $chains         = {},
  $interval       = undef,
) {
  validate_hash($chains)

  if $::osfamily == 'Redhat' {
    if $manage_package {
      package { 'collectd-iptables':
        ensure => $ensure_package,
      }
    }
  }

  collectd::plugin {'iptables':
    ensure   => $ensure,
    content  => template('collectd/plugin/iptables.conf.erb'),
    interval => $interval,
  }
}
