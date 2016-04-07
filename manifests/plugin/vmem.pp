# https://collectd.org/wiki/index.php/Plugin:vmem
class collectd::plugin::vmem (
  $ensure = undef
  $interval = undef,
  $verbose  = false,
) {

  include ::collectd

  collectd::plugin { 'vmem':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/vmem.conf.erb'),
    interval => $interval,
  }
}
