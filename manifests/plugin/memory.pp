# https://collectd.org/wiki/index.php/Plugin:Memory
class collectd::plugin::memory (
  $ensure                   = 'present',
  $interval                 = undef,
  Boolean $valuesabsolute   = true,
  Boolean $valuespercentage = false
) {

  include collectd

  collectd::plugin { 'memory':
    ensure   => $ensure,
    content  => template('collectd/plugin/memory.conf.erb'),
    interval => $interval,
  }
}
