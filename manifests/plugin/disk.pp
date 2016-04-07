# https://collectd.org/wiki/index.php/Plugin:Disk
class collectd::plugin::disk (
  $ensure = undef
  $disks          = [],
  $ignoreselected = false,
  $interval       = undef,
  $udevnameattr   = undef,
) {

  include ::collectd

  validate_array($disks)
  validate_bool($ignoreselected)

  collectd::plugin { 'disk':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/disk.conf.erb'),
    interval => $interval,
  }
}
