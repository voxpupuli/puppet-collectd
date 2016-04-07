# https://collectd.org/wiki/index.php/Plugin:Users
class collectd::plugin::users (
  $ensure = undef
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'users':
    ensure   => $ensure_real,
    interval => $interval,
  }
}
