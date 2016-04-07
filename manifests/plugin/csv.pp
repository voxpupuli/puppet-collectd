# https://collectd.org/wiki/index.php/Plugin:CSV
class collectd::plugin::csv (
  $ensure = undef
  $datadir    = '/etc/collectd/var/lib/collectd/csv',
  $interval   = undef,
  $storerates = false
) {

  include ::collectd

  collectd::plugin { 'csv':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/csv.conf.erb'),
    interval => $interval,
  }
}
