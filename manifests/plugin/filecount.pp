# https://collectd.org/wiki/index.php/Plugin:FileCount
class collectd::plugin::filecount (
  $ensure      = present,
  $directories = {},
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_hash($directories)

  file { 'filecount.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/filecount.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/filecount.conf.erb'),
    notify    => Service['collectd']
  }
}
