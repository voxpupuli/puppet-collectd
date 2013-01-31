class collectd::plugin::write_graphite (
  $host = 'localhost',
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'write_graphite.conf':
    ensure    => file,
    path      => "${conf_dir}/write_graphite.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/write_graphite.conf.erb'),
  }
}
