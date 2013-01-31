class collectd::plugin::df (
  $mountpoints,
  $fstypes,
  $ignoreselected = 'false',
  $reportbydevice = 'false',
  $reportinodes   = 'true'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'df.conf':
    path      => "${conf_dir}/df.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/df.conf.erb'),
    notify    => Service['collectd'],
  }
}
