# https://collectd.org/wiki/index.php/Load
class collectd::plugin::load (
  $ensure    = present,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'load.conf':
    ensure    => $collectd::plugin::load::ensure,
    path      => "${conf_dir}/load.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/load.conf.erb'),
    notify    => Service['collectd'],
  }
}
