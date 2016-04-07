# https://collectd.org/wiki/index.php/Plugin:Memory
class collectd::plugin::memory (
  $ensure = undef
  $valuesabsolute   = true,
  $valuespercentage = false,
  $interval         = undef,
) {

  include ::collectd

  validate_bool(
    $valuesabsolute,
    $valuespercentage,
  )

  collectd::plugin { 'memory':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/memory.conf.erb'),
    interval => $interval,
  }
}
