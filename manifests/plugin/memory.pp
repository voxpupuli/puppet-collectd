# https://collectd.org/wiki/index.php/Memory
class collectd::plugin::memory (
  $ensure    = present,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'memory.conf':
    ensure    => $collectd::plugin::memory::ensure,
    path      => "${conf_dir}/memory.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/memory.conf.erb'),
    notify    => Service['collectd'],
  }
}
