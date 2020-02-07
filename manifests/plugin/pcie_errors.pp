class collectd::plugin::pcie_errors (
  Enum['present', 'absent'] $ensure                   = 'present',
  Optional[String]          $source                   = 'sysfs',
  Optional[String]          $access_dir               = undef,
  Optional[Boolean]         $report_masked            = false,
  Optional[Boolean]         $persistent_notifications = false,
) {

  include collectd

  collectd::plugin { 'pcie_errors':
    ensure  => $ensure,
    content => epp('collectd/plugin/pcie_errors.conf.epp'),
  }
}
