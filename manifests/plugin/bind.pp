# https://collectd.org/wiki/index.php/Plugin:BIND
class collectd::plugin::bind (
  $url,
  $ensure         = present,
  $memorystats    = true,
  $opcodes        = true,
  $parsetime      = false,
  $qtypes         = true,
  $resolverstats  = false,
  $serverstats    = true,
  $zonemaintstats = true,
  $views          = [],
) {

  validate_bool(
    $memorystats,
    $opcodes,
    $parsetime,
    $qtypes,
    $resolverstats,
    $serverstats,
    $zonemaintstats,
  )
  validate_array($views)

  collectd::plugin {'bind':
    ensure  => $ensure,
    content => template('collectd/plugin/bind.conf.erb'),
  }
}
