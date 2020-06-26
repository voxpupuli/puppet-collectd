# https://collectd.org/wiki/index.php/Plugin:SysLog
class collectd::plugin::syslog (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[Float] $interval  = undef,
  Enum['debug', 'info', 'notice', 'warning', 'err'] $log_level = 'info',
  Optional[Enum['OKAY', 'WARNING', 'FAILURE']] $notify_level   = undef
) {
  include collectd

  collectd::plugin { 'syslog':
    ensure   => $ensure,
    content  => epp('collectd/plugin/syslog.conf.epp'),
    interval => $interval,
    # Load logging plugin first
    # https://github.com/puppet-community/puppet-collectd/pull/166#issuecomment-50591413
    order    => '05',
  }
}
