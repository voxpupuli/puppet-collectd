# https://collectd.org/wiki/index.php/Plugin:HDDTemp
class collectd::plugin::hddtemp (
  $ensure       = 'present',
  Stdlib::Host $host = '127.0.0.1',
  $interval     = undef,
  Stdlib::Port $port = 7634
) {

  include collectd

  collectd::plugin { 'hddtemp':
    ensure   => $ensure,
    content  => template('collectd/plugin/hddtemp.conf.erb'),
    interval => $interval,
  }
}
