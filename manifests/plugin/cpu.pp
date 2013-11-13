# https://collectd.org/wiki/index.php/Cpu
class collectd::plugin::cpu (
  $ensure    = present,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'cpu.conf':
    ensure    => $collectd::plugin::cpu::ensure,
    path      => "${conf_dir}/cpu.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/cpu.conf.erb'),
    notify    => Service['collectd'],
  }
}
