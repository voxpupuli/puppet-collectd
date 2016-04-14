class collectd::plugin::write_kafka (
  $ensure     = 'present',
  $kafka_host = 'localhost',
  $kafka_port = 9092,
  $topics     = {},
  $interval   = undef,
) {

  include ::collectd

  validate_hash($topics)

  $kafka_broker = "${kafka_host}:${kafka_port}"

  collectd::plugin { 'write_kafka':
    ensure   => $ensure,
    content  => template('collectd/plugin/write_kafka.conf.erb'),
    interval => $interval,
  }
}
