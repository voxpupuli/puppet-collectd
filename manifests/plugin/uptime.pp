# https://collectd.org/wiki/index.php/Plugin:Uptime
class collectd::plugin::uptime (
  $ensure           = present,
) {
  collectd::plugin {'uptime':
    ensure => $ensure
  }
}
