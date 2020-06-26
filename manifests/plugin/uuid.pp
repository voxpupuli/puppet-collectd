# https://collectd.org/wiki/index.php/Plugin:UUID
class collectd::plugin::uuid (
  $uuid_file = '/etc/uuid',
  $ensure    = 'present',
  $interval  = undef,
) {
  include collectd

  collectd::plugin { 'uuid':
    ensure   => $ensure,
    content  => template('collectd/plugin/uuid.conf.erb'),
    interval => $interval,
  }
}
