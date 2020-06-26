# https://collectd.org/wiki/index.php/Plugin:UUID
class collectd::plugin::uuid (
  $ensure    = 'present',
  $interval  = undef,
  $uuid_file = '/etc/uuid'
) {

  include collectd

  collectd::plugin { 'uuid':
    ensure   => $ensure,
    content  => template('collectd/plugin/uuid.conf.erb'),
    interval => $interval,
  }
}
