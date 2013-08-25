class collectd::plugin::bind (
  $url,
  $parsetime = 'false',
  $opcodes = 'true',
  $qtypes = 'true',
  $serverstats = 'true',
  $zonemaintstats = 'true',
  $resolverstats = 'false',
  $memorystats = 'true',
  $views = [],
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'bind.conf':
    ensure  => $collectd::plugin::bind::ensure,
    path    => "${conf_dir}/bind.conf",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/bind.conf.erb'),
    notify  => Service['collectd']
  }
}
