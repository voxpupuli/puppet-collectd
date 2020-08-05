# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $reportbystate            = true,
  Boolean $reportbycpu              = true,
  Boolean $valuespercentage         = false,
  Boolean $reportnumcpu             = false,
  Boolean $reportgueststate         = false,
  Boolean $subtractgueststate       = true,
  Optional[Integer[1]] $interval    = undef,
) {
  include collectd

  collectd::plugin { 'cpu':
    ensure   => $ensure,
    content  => epp('collectd/plugin/cpu.conf.epp'),
    interval => $interval,
  }
}
