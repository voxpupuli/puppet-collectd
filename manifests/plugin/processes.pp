# https://collectd.org/wiki/index.php/Processes
class collectd::plugin::processes (
  $ensure    = present,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'processes.conf':
    ensure    => $collectd::plugin::processes::ensure,
    path      => "${conf_dir}/processes.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/processes.conf.erb'),
    notify    => Service['collectd'],
  }
}
