class collectd::plugin::iptables (
  $chains = 'UNSET',
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'iptables.conf':
    ensure    => $collectd::plugin::iptables::ensure,
    path      => "${conf_dir}/iptables.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/iptables.conf.erb'),
    notify    => Service['collectd']
  }
}
