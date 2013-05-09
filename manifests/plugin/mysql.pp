class collectd::plugin::mysql (
  $database = 'UNSET',
  $host     = 'UNSET',
  $username = 'UNSET',
  $password = 'UNSET',
  $port     = '3306',
  $ensure   = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'mysql.conf':
    ensure  => $collectd::plugin::mysql::ensure,
    path    => "${conf_dir}/mysql.conf",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/mysql.conf.erb'),
    notify  => Service['collectd'],
  }
}
