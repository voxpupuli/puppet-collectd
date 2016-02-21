# https://collectd.org/wiki/index.php/Plugin:CPUFreq
class collectd::plugin::cpufreq (
  $ensure = 'present',
) {

  include ::collectd

  collectd::plugin { 'cpufreq':
    ensure => $ensure,
  }
}
