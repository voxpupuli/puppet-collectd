#
class collectd::plugin::ceph (
  $ensure                    = present,
  $longrunavglatency         = false,
  $convertspecialmetrictypes = true,
) {

  collectd::plugin {'ceph':
    ensure   => $ensure,
    interval => $interval,
    content  => template('collectd/plugin/ceph.conf.erb'),
  }
  $defaults = {
    'ensure' => $ensure
  }
}
