# https://collectd.org/wiki/index.php/Plugin:Memory
class collectd::plugin::memory (
  $ensure           = present,
  $valuesabsolute   = true,
  $valuespercentage = false,
  $interval         = undef,
) {

  validate_bool(
    $valuesabsolute,
    $valuespercentage,
  )

  collectd::plugin {'memory':
    ensure   => $ensure,
    content  => template('collectd/plugin/memory.conf.erb'),
    interval => $interval,
  }
}
