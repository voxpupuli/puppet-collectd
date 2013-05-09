class collectd::plugin::disk (
  $disks          = 'UNSET',
  $ignoreselected = 'false',
  $ensure         = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'disk.conf':
    ensure    => $collectd::plugin::disk::ensure,
    path      => "${conf_dir}/disk.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/disk.conf.erb'),
    notify    => Service['collectd']
  }

}
