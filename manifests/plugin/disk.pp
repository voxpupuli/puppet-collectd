class collectd::plugin::disk (
  $disks,
  $ignoreselected = 'false'
) {
  include collectd::params

  $conf_dir          = $collectd::params::plugin_conf_dir
  $main_configs_file = $collectd::params::main_configs_file

  file_line { 'include_disk_conf':
    line    => "Include \"${conf_dir}/disk.conf\"",
    path    => $main_configs_file,
    require => Package['collectd'],
  }

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
