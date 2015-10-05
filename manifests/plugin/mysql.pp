# MySQL plugin
# https://collectd.org/wiki/index.php/Plugin:MySQL
class collectd::plugin::mysql (
  $ensure           = present,
  $manage_package   = $true,
  $interval         = undef,
){

  if $::osfamily == 'Redhat' {
    if $manage_package {
      package { 'collectd-mysql':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'mysql':
    interval => $interval,
  }
}
