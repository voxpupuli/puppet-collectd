class collectd::plugin::df (
  $mountpoints,
  $fstypes,
  $ignoreselected = 'false',
  $reportbydevice = 'false',
  $reportinodes   = 'true'
) {
  include collectd::params

  $conf_dir          = $collectd::params::plugin_conf_dir
  $main_configs_file = $collectd::params::main_configs_file

  file_line { 'include_df_conf':
    line    => "Include \"${conf_dir}/df.conf\"",
    path    => $main_configs_file,
    require => Package['collectd'],
  }

  file { 'df.conf':
    path      => "${conf_dir}/df.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/df.conf.erb'),
    subscribe => Service['collectd'],
  }
}
