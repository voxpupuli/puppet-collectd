#
define collectd::plugin::mysql::database (
  $ensure             = 'present',
  $database           = $name,
  $host               = 'UNSET',
  $username           = 'UNSET',
  $password           = 'UNSET',
  $port               = '3306',
  $masterstats        = false,
  $slavestats         = false,
  $socket             = undef,
  $innodbstats        = undef,
  $slavenotifications = undef,
) {

  include ::collectd
  include ::collectd::plugin::mysql

  $conf_dir = $collectd::plugin_conf_dir

  validate_string($database, $host, $username, $password, $port)
  validate_bool($masterstats, $slavestats)
  if $socket {
    validate_string($socket)
  }

  if $innodbstats != undef {
    validate_bool($innodbstats)
  }

  if $slavenotifications != undef {
    validate_bool($slavenotifications)
  }

  file { "${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/mysql-${name}.conf",
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/mysql-database.conf.erb'),
    notify  => Service['collectd'],
  }
}
