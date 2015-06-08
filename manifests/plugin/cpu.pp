# https://collectd.org/wiki/index.php/Plugin:CPU
class collectd::plugin::cpu (
  $ensure           = present,
  $reportbystate    = true,
  $reportbycpu      = true,
  $valuespercentage = false,
  $interval         = undef,
) {

  validate_bool(
    $reportbystate,
    $reportbycpu,
    $valuespercentage,
  )

  collectd::plugin {'cpu':
    ensure   => $ensure,
    content  => template('collectd/plugin/cpu.conf.erb'),
    interval => $interval,
  }
}
