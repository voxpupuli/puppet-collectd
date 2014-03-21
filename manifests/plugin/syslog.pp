# https://collectd.org/wiki/index.php/Plugin:SysLog
class collectd::plugin::syslog (
  $ensure    = present,
  $log_level = 'info'
) {

  collectd::plugin {'syslog':
    ensure  => $ensure,
    content => template('collectd/plugin/syslog.conf.erb'),
  }
}
