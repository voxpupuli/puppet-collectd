# https://collectd.org/wiki/index.php/Plugin:SysLog
class collectd::plugin::syslog (
  $ensure = undef
  $interval  = undef,
  $log_level = 'info'
) {

  include ::collectd

  collectd::plugin { 'syslog':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/syslog.conf.erb'),
    interval => $interval,
    # Load logging plugin first
    # https://github.com/puppet-community/puppet-collectd/pull/166#issuecomment-50591413
    order    => '05',
  }
}
