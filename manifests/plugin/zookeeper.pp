class collectd::plugin::zookeeper (
  Enum['present', 'absent'] $ensure           = 'present',
  Optional[Integer]         $interval         = undef,
  String                    $zookeeper_host   = 'localhost',
  String                    $zookeeper_port   = '2181',
) {

  include ::collectd

  collectd::plugin { 'zookeeper':
    ensure   => $ensure,
    content  => template('collectd/plugin/zookeeper.conf.erb'),
    interval => $interval,
  }
}
