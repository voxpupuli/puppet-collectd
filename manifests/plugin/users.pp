# https://collectd.org/wiki/index.php/Plugin:Users
class collectd::plugin::users (
  $ensure   = present,
  $interval = undef,
) {

  collectd::plugin {'users':
    ensure   => $ensure,
    interval => $interval,
  }
}
