class collectd::plugin::unixsock (
  $socketfile  = '/var/run/collectd-socket',
  $socketgroup = 'collectd',
  $socketperms = '0770',
  $ensure      = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'unixsock.conf':
    ensure    => $collectd::plugin::unixsock::ensure,
    path      => "${conf_dir}/unixsock.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/unixsock.conf.erb'),
    notify    => Service['collectd']
  }
}
