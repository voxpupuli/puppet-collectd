# https://collectd.org/wiki/index.php/Plugin:BIND
class collectd::plugin::bind (
  $url,
  $ensure         = present,
  $memorystats    = true,
  $opcodes        = true,
  $parsetime      = false,
  $qtypes         = true,
  $resolverstats  = false,
  $serverstats    = true,
  $zonemaintstats = true,
  $views          = [],
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_bool(
    $memorystats,
    $opcodes,
    $parsetime,
    $qtypes,
    $resolverstats,
    $serverstats,
    $zonemaintstats,
  )
  validate_array($views)

  file { 'bind.conf':
    ensure  => $collectd::plugin::bind::ensure,
    path    => "${conf_dir}/bind.conf",
    mode    => '0644',
    owner   => 'root',
    group   => $collectd::params::root_group,
    content => template('collectd/bind.conf.erb'),
    notify  => Service['collectd']
  }
}
