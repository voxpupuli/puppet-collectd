# https://collectd.org/wiki/index.php/Plugin:CSV
class collectd::plugin::csv (
  $ensure           = present,
  $datadir          = '/etc/collectd/var/lib/collectd/csv',
  $storerates       = false
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'csv.conf':
    ensure    => $collectd::plugin::csv::ensure,
    path      => "${conf_dir}/csv.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/csv.conf.erb'),
    notify    => Service['collectd'],
  }
}
