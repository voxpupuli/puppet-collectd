class collectd::plugin::mysql (
  $database,
  $host,
  $username,
  $password,
  $port = '3306',
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

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
