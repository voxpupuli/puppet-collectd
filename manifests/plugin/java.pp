# https://collectd.org/wiki/index.php/Plugin:Java
class collectd::plugin::java (
  $ensure   = 'present',
  $jvmarg   = [],
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'java':
    ensure   => $ensure,
    content  => template('collectd/plugin/java.conf.erb'),
    interval => $interval,
  }
}
