#
define collectd::plugin::mysql::database (
  Enum['present', 'absent'] $ensure    = 'present',
  String $database                     = $name,
  String $host                         = 'UNSET',
  String $username                     = 'UNSET',
  String $password                     = 'UNSET',
  Stdlib::Port $port                   = 3306,
  Boolean $masterstats                 = false,
  Boolean $slavestats                  = false,
  Optional[String] $socket             = undef,
  Optional[Boolean] $innodbstats       = undef,
  # FIXME(sileht): Should be boolean
  Optional[String] $slavenotifications = undef,
  Optional[Boolean] $wsrepstats        = undef,
  Optional[String] $aliasname          = undef,
  Optional[Integer] $connecttimeout    = undef,
  Optional[String] $sslkey             = undef,
  Optional[String] $sslcert            = undef,
  Optional[String] $sslca              = undef,
  Optional[String] $sslcapath          = undef,
  Optional[String] $sslcipher          = undef,
) {
  include collectd
  include collectd::plugin::mysql

  file { "${name}.conf":
    ensure  => $ensure,
    path    => "${collectd::plugin_conf_dir}/mysql-${name}.conf",
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/mysql-database.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
