# https://collectd.org/wiki/index.php/Plugin:Interface
class collectd::plugin::interface (
  $ensure         = present,
  $interfaces     = [],
  $ignoreselected = false,
) {

  validate_array($interfaces)
  validate_bool($ignoreselected)

  collectd::plugin {'interface':
    ensure  => $ensure,
    content => template('collectd/plugin/interface.conf.erb'),
  }
}
