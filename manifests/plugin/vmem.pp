# https://collectd.org/wiki/index.php/Plugin:vmem
class collectd::plugin::vmem (
  $ensure  = present,
  $verbose = false,
) {
  collectd::plugin {'vmem':
    ensure  => $ensure,
    content => template('collectd/plugin/vmem.conf.erb'),
  }
}
