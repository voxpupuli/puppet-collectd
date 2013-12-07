# https://collectd.org/wiki/index.php/Plugin:IPTables
class collectd::plugin::iptables (
  $ensure = present,
  $chains = [],
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_hash($chains)

  file { 'iptables.conf':
    ensure    => $collectd::plugin::iptables::ensure,
    path      => "${conf_dir}/iptables.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/iptables.conf.erb'),
    notify    => Service['collectd']
  }
}
