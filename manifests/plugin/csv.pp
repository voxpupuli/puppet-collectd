# https://collectd.org/wiki/index.php/Plugin:CSV
class collectd::plugin::csv (
  $datadir    = '/etc/collectd/var/lib/collectd/csv',
  $ensure     = 'present',
  $interval   = undef,
  $storerates = false
) {

  include collectd

  collectd::plugin { 'csv':
    ensure   => $ensure,
    content  => template('collectd/plugin/csv.conf.erb'),
    interval => $interval,
  }
}
