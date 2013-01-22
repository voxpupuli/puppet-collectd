class collectd::plugin::mysql (
  $database,
  $host,
  $username,
  $password,
  $port = '3306',
) {
  include collectd::params

  $conf_dir          = $collectd::params::plugin_conf_dir
  $main_configs_file = $collectd::params::main_configs_file

  file_line { 'include_mysql_conf':
    line    => "Include \"${conf_dir}/mysql.conf\"",
    path    => $main_configs_file,
    require => Package['collectd'],
  }

  file { 'mysql.conf':
    ensure  => file,
    path    => "${conf_dir}/mysql.conf",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/mysql.conf.erb'),
    notify  => Service['collectd'],
  }
}
