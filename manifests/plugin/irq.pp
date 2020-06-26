# https://collectd.org/wiki/index.php/Plugin:IRQ
class collectd::plugin::irq (
  $ensure                 = 'present',
  Array $irqs             = [],
  Boolean $ignoreselected = false,
  $interval               = undef,
) {
  include collectd

  collectd::plugin { 'irq':
    ensure   => $ensure,
    content  => template('collectd/plugin/irq.conf.erb'),
    interval => $interval,
  }
}
