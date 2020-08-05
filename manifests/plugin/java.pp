# https://collectd.org/wiki/index.php/Plugin:Java
class collectd::plugin::java (
  $ensure                                   = 'present',
  $jvmarg                                   = [],
  $loadplugin                               = {},
  $interval                                 = undef,
  $manage_package                           = undef,
  Optional[Stdlib::Absolutepath] $java_home = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-java':
        ensure => $ensure,
      }
    }
    if $java_home {
      exec { 'Link libjvm.so on OpenJDK':
        command => "/usr/bin/ln -s ${java_home}/jre/lib/server/libjvm.so /usr/lib64/libjvm.so",
        creates => '/usr/lib64/libjvm.so',
        onlyif  => "/usr/bin/test -e ${java_home}/jre/lib/server/libjvm.so",
        notify  => Exec['/sbin/ldconfig'],
      }

      exec { 'Link libjvm.so on Oracle':
        command => "/usr/bin/ln -s ${java_home}/jre/lib/amd64/server/libjvm.so /usr/lib64/libjvm.so",
        creates => '/usr/lib64/libjvm.so',
        onlyif  => "/usr/bin/test -e ${java_home}/jre/lib/amd64/server/libjvm.so",
        notify  => Exec['/sbin/ldconfig'],
      }

      # Reload SO files so libjvm.so can be found
      exec { '/sbin/ldconfig':
        unless  => '/sbin/ldconfig -p |grep libjvm.so >/dev/null 2>&1',
        require => [Exec['Link libjvm.so on OpenJDK'], Exec['Link libjvm.so on Oracle']],
      }
    }
  }

  collectd::plugin { 'java':
    ensure   => $ensure,
    content  => template('collectd/plugin/java.conf.erb'),
    interval => $interval,
  }
}
