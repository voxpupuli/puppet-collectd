#== Class: collectd::plugin::smart
#
# Class to manage smart plugin for collectd 
# === Parameters
# [*ensure*]
#   ensure param for collectd::plugin type
# 
# [*disks*]
#   array of disks to create config for 
#   example: ['sda', 'sdb', 'sdc']
#
# [*ignoreselected*]
#   If enabled, ignore given disks
#
class collectd::plugin::smart (
  $ensure                 = present,
  $ignoreselected         = false,
  $disks                  = [],
) {

  validate_array($disks)

  collectd::plugin {'smart':
    ensure  => $ensure,
    content => template('collectd/plugin/smart.conf.erb'),
  }
}
