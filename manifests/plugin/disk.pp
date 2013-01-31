class collectd::plugin::disk (
  $disks,
  $ignoreselected = 'false'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'disk.conf':
    path      => "${conf_dir}/disk.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/disk.conf.erb'),
    notify    => Service['collectd']
  }

}
