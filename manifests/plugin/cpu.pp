# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  $ensure           = 'present',
  $reportbystate    = true,
  $reportbycpu      = true,
  $valuespercentage = false,
  $reportnumcpu     = false,
  $interval         = undef,
) {

  include ::collectd

  validate_bool(
    $reportbystate,
    $reportbycpu,
    $valuespercentage,
    $reportnumcpu,
  )

  collectd::plugin { 'cpu':
    ensure   => $ensure,
    content  => template('collectd/plugin/cpu.conf.erb'),
    interval => $interval,
  }
}
