# https://collectd.org/wiki/index.php/Plugin:NTPd
class collectd::plugin::ntpd (
  $ensure           = present,
  $host             = 'localhost',
  $port             = 123,
  $reverselookups   = false,
  $includeunitid    = false,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'ntpd.conf':
    ensure    => $collectd::plugin::ntpd::ensure,
    path      => "${conf_dir}/ntpd.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/ntpd.conf.erb'),
    notify    => Service['collectd'],
  }
}
