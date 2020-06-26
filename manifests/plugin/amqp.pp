# https://collectd.org/wiki/index.php/Plugin:AMQP
class collectd::plugin::amqp (
  String $amqpexchange               = 'metrics',
  Collectd::Amqp::Format $amqpformat = 'Graphite',
  Stdlib::Host $amqphost             = 'localhost',
  String $amqppass                   = 'graphite',
  Boolean $amqppersistent            = true,
  Stdlib::Port $amqpport             = 5672,
  String $amqproutingkey             = 'collectd',
  Boolean $amqpstorerates            = false,
  String $amqpuser                   = 'graphite',
  String $amqpvhost                  = 'graphite',
  Enum['present', 'absent'] $ensure  = 'present',
  String[1] $escapecharacter         = '_',
  Boolean $graphitealwaysappendds    = false,
  String $graphiteprefix             = 'collectd.',
  Boolean $graphiteseparateinstances = false,
  Optional[Integer[1]] $interval     = undef,
  Boolean $manage_package            = $collectd::manage_package
) {

  include collectd

  if $facts['os']['family'] == 'RedHat' {
    if $manage_package {
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
