# https://collectd.org/wiki/index.php/Plugin:FileCount
class collectd::plugin::filecount (
  $ensure      = present,
  $directories = undef,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_hash($directories)

  if ! $directories or ! is_hash($directories) {
    fail('directories are not properly set')
  }
  file { 'filecount.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/filecount.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/filecount.conf.erb'),
    notify    => Service['collectd']
  }
}

