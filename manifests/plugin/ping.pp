# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ping
define collectd::plugin::ping (
  $hosts,
  $interval       = undef,
  $timeout        = undef,
  $ttl            = undef,
  $source_address = undef,
  $device         = undef,
  $max_missed     = undef,
) {
  include collectd::params

  validate_array($hosts)

  $conf_dir = $collectd::params::plugin_conf_dir

  file {
    "${name}.load":
      path    => "${conf_dir}/ping-${name}.conf",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0644',
      content => template('collectd/ping.conf.erb'),
      notify  => Service['collectd'],
  }
}
