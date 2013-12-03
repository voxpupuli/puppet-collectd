# https://collectd.org/wiki/index.php/Plugin:Swap
class collectd::plugin::swap (
  $ensure    = present,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'swap.conf':
    ensure    => $collectd::plugin::swap::ensure,
    path      => "${conf_dir}/swap.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/swap.conf.erb'),
    notify    => Service['collectd'],
  }
}
