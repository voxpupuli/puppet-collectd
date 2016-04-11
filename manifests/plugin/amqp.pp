# https://collectd.org/wiki/index.php/Plugin:AMQP
class collectd::plugin::amqp (
  $ensure                     = 'present',
  $manage_package             = undef,
  $amqphost                   = 'localhost',
  $amqpport                   = 5672,
  $amqpvhost                  = 'graphite',
  $amqpuser                   = 'graphite',
  $amqppass                   = 'graphite',
  $amqpformat                 = 'Graphite',
  $amqpstorerates             = false,
  $amqpexchange               = 'metrics',
  $amqppersistent             = true,
  $graphiteprefix             = 'collectd.',
  $escapecharacter            = '_',
  $interval                   = undef,
  $graphiteseparateinstances  = false,
  $graphitealwaysappendds     = false,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_bool($amqppersistent, $graphiteseparateinstances, $graphitealwaysappendds)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-amqp':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'amqp':
    ensure   => $ensure,
    content  => template('collectd/plugin/amqp.conf.erb'),
    interval => $interval,
  }
}
