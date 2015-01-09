# MySQL plugin
# https://collectd.org/wiki/index.php/Plugin:MySQL
class collectd::plugin::mysql (
  $interval = undef,
){

  if $::osfamily == 'Redhat' {
    package { 'collectd-mysql':
      ensure => $ensure,
    }
  }

  collectd::plugin { 'mysql':
    interval => $interval,
  }
}
