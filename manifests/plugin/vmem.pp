# https://collectd.org/wiki/index.php/Plugin:vmem
class collectd::plugin::vmem (
  $ensure   = 'present',
  $interval = undef,
  $verbose  = false,
) {
  include collectd

  collectd::plugin { 'vmem':
    ensure   => $ensure,
    content  => template('collectd/plugin/vmem.conf.erb'),
    interval => $interval,
  }
}
