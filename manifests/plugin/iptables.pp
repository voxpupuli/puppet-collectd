class collectd::plugin::iptables (
  $chains,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'iptables.conf':
    path      => "${conf_dir}/iptables.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/iptables.conf.erb'),
    notify    => Service['collectd']
  }
}
