# https://collectd.org/wiki/index.php/Plugin:CPUFreq
class collectd::plugin::cpufreq (
  Enum['present', 'absent'] $ensure = 'present',
) {
  include collectd

  collectd::plugin { 'cpufreq':
    ensure => $ensure,
  }
}
