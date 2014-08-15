# https://collectd.org/wiki/index.php/Plugin:SysLog
class collectd::plugin::syslog (
  $ensure    = present,
  $log_level = 'info'
) {

  collectd::plugin {'syslog':
    ensure  => $ensure,
    content => template('collectd/plugin/syslog.conf.erb'),
    # Load logging plugin first
    # https://github.com/pdxcat/puppet-module-collectd/pull/166#issuecomment-50591413
    order   => '05',
  }
}
