# https://collectd.org/wiki/index.php/Plugin:SysLog
class collectd::plugin::syslog (
  $ensure    = present,
  $interval  = undef,
  $log_level = 'info'
) {

  collectd::plugin {'syslog':
    ensure   => $ensure,
    content  => template('collectd/plugin/syslog.conf.erb'),
    interval => $interval,
    # Load logging plugin first
    # https://github.com/puppet-community/puppet-collectd/pull/166#issuecomment-50591413
    order    => '05',
  }
}
