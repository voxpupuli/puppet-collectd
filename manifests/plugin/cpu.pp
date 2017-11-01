# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  $ensure           = 'present',
  Boolean $reportbystate    = true,
  Boolean $reportbycpu      = true,
  Boolean $valuespercentage = false,
  Boolean $reportnumcpu     = false,
  $interval         = undef,
) {

  include ::collectd

  collectd::plugin { 'cpu':
    ensure   => $ensure,
    content  => template('collectd/plugin/cpu.conf.erb'),
    interval => $interval,
  }
}
