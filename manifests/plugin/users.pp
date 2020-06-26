# https://collectd.org/wiki/index.php/Plugin:Users
class collectd::plugin::users (
  $ensure   = 'present',
  $interval = undef,
) {
  include collectd

  collectd::plugin { 'users':
    ensure   => $ensure,
    interval => $interval,
  }
}
