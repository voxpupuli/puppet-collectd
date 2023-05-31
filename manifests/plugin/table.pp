# @summary Load and configure the table plugin
# @see https://collectd.org/wiki/index.php/Plugin:Table
#
# @param tables `<Table>` blocks for table plugin
# @param ensure Should the plugin be configured
# @param order Prefix of file in collectd config directory
#
# @example Parse `/proc/pressure/cpu`
#   class {'collectd::plugin::table':
#     tables => {
#       '/proc/pressure/cpu' => {
#         'plugin'    => 'psi',
#         'instance   => 'cpu',
#         'seperator' => ' =',
#         'results'   => [{
#           'type'            => 'gauge',
#           'instance_from'   => [0],
#           'instance_prefix' => 'arg10',
#           'values_from'     => [2],
#         }],
#       }
#     }
#   }
#
class collectd::plugin::table (
  Optional[Hash[String, Collectd::Table::Table, 1]] $tables = undef,
  Enum['present', 'absent'] $ensure                         = 'present',
  Integer $order                                            = 10,
) {
  include collectd

  $_content = $tables ? {
    Undef   => undef,
    default => epp('collectd/plugin/table.conf.epp', { 'tables' => $tables }),
  }

  collectd::plugin { 'table':
    ensure  => $ensure,
    content => $_content,
    order   => $order,
  }
}
