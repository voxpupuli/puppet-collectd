# https://collectd.org/wiki/index.php/Plugin:IRQ
class collectd::plugin::irq (
  $ensure                 = 'present',
  Boolean $ignoreselected = false,
  $interval               = undef,
  Array $irqs             = []
) {

  include collectd

  collectd::plugin { 'irq':
    ensure   => $ensure,
    content  => template('collectd/plugin/irq.conf.erb'),
    interval => $interval,
  }
}
