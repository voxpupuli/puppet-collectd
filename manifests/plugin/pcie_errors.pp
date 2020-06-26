# Class to manage pcie_errors plugin for collectd
#
# @param ensure Ensure param for collectd::plugin type.
# @param source Use sysfs or proc to read data from /sysfs or /proc.
# @param access_dir Directory used to access device config space.
# @param report_masked If true plugin will notify about errors that are set to masked in Error Mask register.
# @param persistent_notifications If false plugin will dispatch notification only on set/clear of error.
#
class collectd::plugin::pcie_errors (
  Enum['present', 'absent'] $ensure                   = 'present',
  Enum['sysfs', 'proc']     $source                   = 'sysfs',
  Optional[String]          $access_dir               = undef,
  Boolean                   $report_masked            = false,
  Boolean                   $persistent_notifications = false,
) {
  include collectd

  collectd::plugin { 'pcie_errors':
    ensure  => $ensure,
    content => epp('collectd/plugin/pcie_errors.conf.epp'),
  }
}
