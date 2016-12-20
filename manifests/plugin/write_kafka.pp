class collectd::plugin::write_kafka (
  $ensure     = 'present',
  $kafka_host = undef,
  $kafka_hosts = ['localhost:9092'],
  $kafka_port = 9092,
  $topics     = {},
  $interval   = undef,
) {

  include ::collectd

  validate_hash($topics)
  validate_array($kafka_hosts)

  if($kafka_host and $kafka_port) {
    $real_kafka_hosts = [ "${kafka_host}:${kafka_port}" ]
  } else {
    $real_kafka_hosts = $kafka_hosts
  }
  $kafka_broker = join($real_kafka_hosts, ',')

  collectd::plugin { 'write_kafka':
    ensure   => $ensure,
    content  => template('collectd/plugin/write_kafka.conf.erb'),
    interval => $interval,
  }
}
