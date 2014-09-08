#
define collectd::plugin::mysql::database (
  $ensure      = 'present',
  $database    = $name,
  $host        = 'UNSET',
  $username    = 'UNSET',
  $password    = 'UNSET',
  $port        = '3306',
  $masterstats = false,
  $slavestats  = false,
  $socket      = undef,
) {
  include collectd::params
  include collectd::plugin::mysql

  $conf_dir = $collectd::params::plugin_conf_dir

  validate_string($database, $host, $username, $password, $port)
  validate_bool($masterstats, $slavestats)
  if $socket {
    validate_string($socket)
  }

  if ($masterstats == true and $slavestats == true) {
    fail('master and slave statistics are mutually exclusive.')
  }

  file { "${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/mysql-${name}.conf",
    mode    => '0644',
    owner   => 'root',
    group   => $collectd::params::root_group,
    content => template('collectd/mysql-database.conf.erb'),
    notify  => Service['collectd'],
  }
}
