class collectd::plugin::syslog (
  $ensure    = present,
  $log_level = 'info'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'syslog.conf':
    ensure    => $collectd::plugin::syslog::ensure,
    path      => "${conf_dir}/syslog.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/syslog.conf.erb'),
    notify    => Service['collectd'],
  }
}
