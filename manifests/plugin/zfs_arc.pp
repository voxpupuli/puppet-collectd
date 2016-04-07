# https://collectd.org/wiki/index.php/Plugin:ZFS_ARC
class collectd::plugin::zfs_arc (
  $ensure = undef
) {

  include ::collectd

  collectd::plugin { 'zfs_arc':
    ensure => $ensure_real,
  }
}
