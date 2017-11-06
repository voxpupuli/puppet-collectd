# https://collectd.org/wiki/index.php/Plugin:AMQP
class collectd::plugin::amqp (
  $ensure                            = 'present',
  $manage_package                    = undef,
  $amqphost                          = 'localhost',
  $amqpport                          = 5672,
  $amqpvhost                         = 'graphite',
  $amqpuser                          = 'graphite',
  $amqppass                          = 'graphite',
  $amqpformat                        = 'Graphite',
  $amqpstorerates                    = false,
  $amqpexchange                      = 'metrics',
  Boolean $amqppersistent            = true,
  $amqproutingkey                    = 'collectd',
  $graphiteprefix                    = 'collectd.',
  $escapecharacter                   = '_',
  $interval                          = undef,
  Boolean $graphiteseparateinstances = false,
  Boolean $graphitealwaysappendds    = false,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
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
