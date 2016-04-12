# https://collectd.org/wiki/index.php/Plugin:Java
class collectd::plugin::java (
  $ensure         = 'present',
  $jvmarg         = [],
  $loadplugin     = {},
  $interval       = undef,
  $manage_package = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-java':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'java':
    ensure   => $ensure,
    content  => template('collectd/plugin/java.conf.erb'),
    interval => $interval,
  }
}
