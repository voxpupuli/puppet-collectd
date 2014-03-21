# https://collectd.org/wiki/index.php/Plugin:IRQ
class collectd::plugin::irq (
  $ensure         = present,
  $irqs           = [],
  $ignoreselected = false,
) {
  validate_array($irqs)
  validate_bool($ignoreselected)

  collectd::plugin {'irq':
    ensure  => $ensure,
    content => template('collectd/plugin/irq.conf.erb'),
  }
}
