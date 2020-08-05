# https://collectd.org/wiki/index.php/Plugin:Memory
class collectd::plugin::memory (
  $ensure                   = 'present',
  Boolean $valuesabsolute   = true,
  Boolean $valuespercentage = false,
  $interval                 = undef,
) {
  include collectd

  collectd::plugin { 'memory':
    ensure   => $ensure,
    content  => template('collectd/plugin/memory.conf.erb'),
    interval => $interval,
  }
}
