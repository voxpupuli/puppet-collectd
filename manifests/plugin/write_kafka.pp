class collectd::plugin::write_kafka (
  $ensure                    = 'present',
  $kafka_host                = undef,
  Array[String] $kafka_hosts = ['localhost:9092'],
  Stdlib::Port $kafka_port   = 9092,
  Hash $topics               = {},
  Hash $properties           = {},
  Hash $meta                 = {},
) {
  include collectd

  if($kafka_host and $kafka_port) {
    $real_kafka_hosts = ["${kafka_host}:${kafka_port}"]
  } else {
    $real_kafka_hosts = $kafka_hosts
  }
  $kafka_broker = join($real_kafka_hosts, ',')

  collectd::plugin { 'write_kafka':
    ensure  => $ensure,
    content => template('collectd/plugin/write_kafka.conf.erb'),
  }
}
