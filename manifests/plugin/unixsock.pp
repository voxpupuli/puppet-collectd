# https://collectd.org/wiki/index.php/Plugin:UnixSock
class collectd::plugin::unixsock (
  $socketfile  = '/var/run/collectd-socket',
  $socketgroup = 'collectd',
  $socketperms = '0770',
  $ensure      = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_absolute_path($socketfile)

  file { 'unixsock.conf':
    ensure    => $collectd::plugin::unixsock::ensure,
    path      => "${conf_dir}/unixsock.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/unixsock.conf.erb'),
    notify    => Service['collectd']
  }
}
