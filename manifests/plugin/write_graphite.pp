class collectd::plugin::write_graphite (
  $host = 'localhost',
) {
  include collectd::params

  $conf_dir          = $collectd::params::plugin_conf_dir
  $main_configs_file = $collectd::params::main_configs_file

  file_line { 'include_write_graphite_conf':
    line => "Include \"${conf_dir}/write_graphite.conf\"",
    path => $main_configs_file,
    require => File['collectd.conf'],
  }

  file { 'write_graphite.conf':
    ensure    => file,
    path      => "${conf_dir}/write_graphite.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/write_graphite.conf.erb'),
  }
}
