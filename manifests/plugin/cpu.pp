# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $reportbystate            = true,
  Boolean $reportbycpu              = true,
  Boolean $valuespercentage         = false,
  Boolean $reportnumcpu             = false,
  Optional[Integer[1]] $interval    = undef,
) {

  include ::collectd

  collectd::plugin { 'cpu':
    ensure   => $ensure,
    content  => template('collectd/plugin/cpu.conf.erb'),
    interval => $interval,
  }
}
