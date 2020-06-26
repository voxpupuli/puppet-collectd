# https://collectd.org/wiki/index.php/Plugin:AMQP
class collectd::plugin::amqp (
  Enum['present', 'absent'] $ensure  = 'present',
  Boolean $manage_package            = $collectd::manage_package,
  Stdlib::Host $amqphost             = 'localhost',
  Stdlib::Port $amqpport             = 5672,
  String $amqpvhost                  = 'graphite',
  String $amqpuser                   = 'graphite',
  String $amqppass                   = 'graphite',
  Collectd::Amqp::Format $amqpformat = 'Graphite',
  Boolean $amqpstorerates            = false,
  String $amqpexchange               = 'metrics',
  Boolean $amqppersistent            = true,
  String $amqproutingkey             = 'collectd',
  String $graphiteprefix             = 'collectd.',
  String[1] $escapecharacter         = '_',
  Optional[Integer[1]] $interval     = undef,
  Boolean $graphiteseparateinstances = false,
  Boolean $graphitealwaysappendds    = false,
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
