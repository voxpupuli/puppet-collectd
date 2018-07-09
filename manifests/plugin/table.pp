# https://collectd.org/wiki/index.php/Chains
class collectd::plugin::table (
  Hash[String, Collectd::Table::Table, 1] $tables,
  Enum['present', 'absent'] $ensure    = 'present',
  Integer $order                       = 10,
) {
  include collectd

  collectd::plugin { 'table':
    ensure  => $ensure,
    content => epp('collectd/plugin/table.conf.epp'),
    order   => $order,
  }
}
