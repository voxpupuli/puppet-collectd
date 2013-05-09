class collectd::plugin::irq (
  $irqs           = 'UNSET',
  $ignoreselected = 'false',
  $ensure         = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'irq.conf':
    ensure    => $collectd::plugin::irq::ensure,
    path      => "${conf_dir}/irq.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/irq.conf.erb'),
    notify    => Service['collectd']
  }
}
