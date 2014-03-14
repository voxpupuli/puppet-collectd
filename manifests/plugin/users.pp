# https://collectd.org/wiki/index.php/Plugin:Users
class collectd::plugin::users (
  $ensure = present,
) {

  collectd::plugin {'users':
    ensure => $ensure
  }
}
