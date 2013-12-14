# https://collectd.org/wiki/index.php/Plugin:AMQP
class collectd::plugin::amqp (
  $ensure          = present,
  $amqphost        = 'localhost',
  $amqpport        = 5672,
  $amqpvhost       = 'graphite',
  $amqpuser        = 'graphite',
  $amqppass        = 'graphite',
  $amqpformat      = 'Graphite',
  $amqpexchange    = 'metrics',
  $amqppersistent  = true,
  $graphiteprefix  = 'collectd.',
  $escapecharacter = '_',
) {
  include collectd::params

  validate_bool($amqppersistent)

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'amqp.conf':
    ensure    => $collectd::plugin::amqp::ensure,
    path      => "${conf_dir}/amqp.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/amqp.conf.erb'),
    notify    => Service['collectd'],
  }
}
