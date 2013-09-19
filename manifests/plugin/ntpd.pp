class collectd::plugin::ntpd (
  $host = 'localhost',
  $port = '123',
  $reverselookups = 'false',
  $includeunitid = 'false',
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'ntpd.conf':
    ensure    => $collectd::plugin::ntpd::ensure,
    path      => "${conf_dir}/ntpd.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/ntpd.conf.erb'),
    notify    => Service['collectd'],
  }
}
