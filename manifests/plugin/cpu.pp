# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[Integer[1]] $interval    = undef,
  Boolean $reportbycpu              = true,
  Boolean $reportbystate            = true,
  Boolean $reportgueststate         = false,
  Boolean $reportnumcpu             = false,
  Boolean $subtractgueststate       = true,
  Boolean $valuespercentage         = false
) {

  include collectd

  collectd::plugin { 'cpu':
    ensure   => $ensure,
    content  => epp('collectd/plugin/cpu.conf.epp'),
    interval => $interval,
  }
}
