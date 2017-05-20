class collectd::plugin::zookeeper (
  $ensure           = 'present',
  $interval         = undef,
  $zookeeper_host   = 'localhost',
  $zookeeper_port   = 2181,
) {

  include ::collectd

  collectd::plugin { 'zookeeper':
    ensure   => $ensure,
    content  => template('collectd/plugin/zookeeper.conf.erb'),
    interval => $interval,
  }
}
