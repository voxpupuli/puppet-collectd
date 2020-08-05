# https://collectd.org/wiki/index.php/Plugin:ZFS_ARC
class collectd::plugin::zfs_arc (
  $ensure = 'present',
) {
  include collectd

  collectd::plugin { 'zfs_arc':
    ensure => $ensure,
  }
}
