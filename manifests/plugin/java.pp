# https://collectd.org/wiki/index.php/Plugin:Java
class collectd::plugin::java (
  $ensure         = 'present',
  $jvmarg         = [],
  $loadplugin     = {},
  $interval       = undef,
  $manage_package = undef,
  $java_home      = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-java':
        ensure => $ensure,
      }
    }
    if $java_home {
      validate_string($java_home)
      file { '/usr/lib64/libjvm.so':
        ensure => 'link',
        target => "${java_home}/jre/lib/amd64/server/libjvm.so",
      } ->
      # Reload SO files so libjvm.so can be found
      exec { '/sbin/ldconfig':
        unless => '/sbin/ldconfig -p |grep libjvm.so >/dev/null 2>&1',
      }
    }
  }

  collectd::plugin { 'java':
    ensure   => $ensure,
    content  => template('collectd/plugin/java.conf.erb'),
    interval => $interval,
  }
}
