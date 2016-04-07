# https://collectd.org/wiki/index.php/Plugin:Java
class collectd::plugin::java (
  $ensure = undef
  $jvmarg     = [],
  $loadplugin = {},
  $interval   = undef,
) {

  include ::collectd

  collectd::plugin { 'java':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/java.conf.erb'),
    interval => $interval,
  }
}
