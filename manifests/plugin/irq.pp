# https://collectd.org/wiki/index.php/Plugin:IRQ
class collectd::plugin::irq (
  $ensure = undef
  $irqs           = [],
  $ignoreselected = false,
  $interval       = undef,
) {

  include ::collectd

  validate_array($irqs)
  validate_bool($ignoreselected)

  collectd::plugin { 'irq':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/irq.conf.erb'),
    interval => $interval,
  }
}
