#
define collectd::plugin::mysql::database (
  Enum['present', 'absent'] $ensure    = 'present',
  String $database                     = $name,
  String $host                         = 'UNSET',
  String $username                     = 'UNSET',
  String $password                     = 'UNSET',
  String $port                         = '3306',
  Boolean $masterstats                 = false,
  Boolean $slavestats                  = false,
  Optional[String] $socket             = undef,
  Optional[Boolean] $innodbstats       = undef,
  Optional[String] $slavenotifications = undef,
  Optional[Boolean] $wsrepstats        = undef,
) {

  include ::collectd
  include ::collectd::plugin::mysql

  file { "${name}.conf":
    ensure  => $ensure,
    path    => "${collectd::plugin_conf_dir}/mysql-${name}.conf",
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/mysql-database.conf.erb'),
    notify  => Service['collectd'],
  }
}
