# https://collectd.org/wiki/index.php/Plugin:Swap
class collectd::plugin::swap (
  $ensure           = present,
  $reportbydevice   = false,
  $reportbytes      = true
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_bool(
    $reportbydevice,
    $reportbytes
  )

  file { 'swap.conf':
    ensure    => $collectd::plugin::swap::ensure,
    path      => "${conf_dir}/swap.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/swap.conf.erb'),
    notify    => Service['collectd'],
  }
}
