# https://collectd.org/wiki/index.php/Plugin:HDDTemp
class collectd::plugin::hddtemp (
  Stdlib::Host $host = '127.0.0.1',
  Stdlib::Port $port = 7634,
  $ensure       = 'present',
  $interval     = undef,
) {
  include collectd

  collectd::plugin { 'hddtemp':
    ensure   => $ensure,
    content  => template('collectd/plugin/hddtemp.conf.erb'),
    interval => $interval,
  }
}
