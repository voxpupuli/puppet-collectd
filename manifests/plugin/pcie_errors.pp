# Class to manage pcie_errors plugin for collectd
#
# @param access_dir Directory used to access device config space.
# @param ensure Ensure param for collectd::plugin type.
# @param persistent_notifications If false plugin will dispatch notification only on set/clear of error.
# @param report_masked If true plugin will notify about errors that are set to masked in Error Mask register.
# @param source Use sysfs or proc to read data from /sysfs or /proc.
#
class collectd::plugin::pcie_errors (
  Optional[String]          $access_dir               = undef,
  Enum['present', 'absent'] $ensure                   = 'present',
  Boolean                   $persistent_notifications = false,
  Boolean                   $report_masked            = false,
  Enum['sysfs', 'proc']     $source                   = 'sysfs'
) {

  include collectd

  collectd::plugin { 'pcie_errors':
    ensure  => $ensure,
    content => epp('collectd/plugin/pcie_errors.conf.epp'),
  }
}
