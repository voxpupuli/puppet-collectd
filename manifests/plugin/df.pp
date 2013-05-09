class collectd::plugin::df (
  $mountpoints    = 'UNSET',
  $fstypes        = 'UNSET',
  $ignoreselected = 'false',
  $reportbydevice = 'false',
  $reportinodes   = 'true',
  $ensure         = present,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'df.conf':
    ensure    => $collectd::plugin::df::ensure,
    path      => "${conf_dir}/df.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/df.conf.erb'),
    notify    => Service['collectd'],
  }
}
