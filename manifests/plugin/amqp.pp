# https://collectd.org/wiki/index.php/Plugin:AMQP
class collectd::plugin::amqp (
  $ensure          = undef
  $manage_package  = undef,
  $package_ensure  = undef,
  $amqphost        = 'localhost',
  $amqpport        = 5672,
  $amqpvhost       = 'graphite',
  $amqpuser        = 'graphite',
  $amqppass        = 'graphite',
  $amqpformat      = 'Graphite',
  $amqpstorerates  = false,
  $amqpexchange    = 'metrics',
  $amqppersistent  = true,
  $graphiteprefix  = 'collectd.',
  $escapecharacter = '_',
  $interval        = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)
  $_package_ensure = pick($package_ensure, $::collectd::package_ensure)
  $ensure_real     = pick($ensure, 'file')

  validate_bool($amqppersistent)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-amqp':
        ensure => $_package_ensure,
      }
    }
  }

  collectd::plugin { 'amqp':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/amqp.conf.erb'),
    interval => $interval,
  }
}
