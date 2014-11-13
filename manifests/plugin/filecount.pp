# https://collectd.org/wiki/index.php/Plugin:FileCount
class collectd::plugin::filecount (
  $ensure      = present,
  $directories = {},
  $interval    = undef,
) {
  collectd::plugin {'filecount':
    ensure   => $ensure,
    content  => template('collectd/plugin/filecount.conf.erb'),
    interval => $interval,
  }
}
