# https://collectd.org/wiki/index.php/Plugin:CPUFreq
class collectd::plugin::cpufreq (
  $ensure = undef
) {

  include ::collectd

  collectd::plugin { 'cpufreq':
    ensure => $ensure_real,
  }
}
