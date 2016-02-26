# https://collectd.org/wiki/index.php/Plugin:IPTables
class collectd::plugin::iptables (
  $ensure         = 'present',
  $ensure_package = 'present',
  $manage_package = undef,
  $chains         = {},
  $interval       = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_hash($chains)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-iptables':
        ensure => $ensure_package,
      }
    }
  }

  collectd::plugin { 'iptables':
    ensure   => $ensure,
    content  => template('collectd/plugin/iptables.conf.erb'),
    interval => $interval,
  }
}
