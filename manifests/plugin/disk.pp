# https://collectd.org/wiki/index.php/Plugin:Disk
class collectd::plugin::disk (
  $disks          = [],
  $ensure         = 'present',
  $ignoreselected = false,
  $interval       = undef,
  $manage_package = undef,
  $package_name   = 'collectd-disk',
  $udevnameattr   = undef,
) {

  include ::collectd

  validate_array($disks)
  validate_bool($ignoreselected)

  if $::osfamily == 'RedHat' {

    if $ensure == 'present' {
      $ensure_real = $::collectd::package_ensure
    } elsif $ensure == 'absent' {
      $ensure_real = 'absent'
    }

  }

  collectd::plugin { 'disk':
    ensure   => $ensure,
    content  => template('collectd/plugin/disk.conf.erb'),
    interval => $interval,
  }
}
