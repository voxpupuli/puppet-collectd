class collectd::plugin::irq (
  $irqs,
  $ignoreselected = 'false'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'irq.conf':
    path      => "${conf_dir}/irq.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/irq.conf.erb'),
    notify    => Service['collectd']
  }
}
