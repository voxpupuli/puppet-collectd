# https://collectd.org/wiki/index.php/Plugin:HDDTemp
class collectd::plugin::hddtemp (
  $host     = '127.0.0.1',
  $port     = 7634,
  $ensure   = 'present',
  $interval = undef,
) {

  include ::collectd

  validate_integer($port)

  collectd::plugin { 'hddtemp':
    ensure   => $ensure,
    content  => template('collectd/plugin/hddtemp.conf.erb'),
    interval => $interval,
  }
}
