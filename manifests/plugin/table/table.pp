# @summary table definition for table plugin
# @param $tablename Name of table typically a filename
# @param $table Table definition
#
# @example Parse the /proc/uptime file
#   collectd::plugin::table::table{'/proc/uptime':
#     table => {
#       'plugin'    => 'uptime',
#       'instance'  => 'first',
#       'separator' => ' ',
#       'results' => [{
#         'type'        => 'gauge',
#         'values_from' => [0],
#       }],
#     }
#   }
#
define collectd::plugin::table::table (
  Enum['present', 'absent'] $ensure    = 'present',
  Stdlib::Unixpath          $tablename = $name,
  Collectd::Table::Table    $table,
) {
  include collectd::plugin::table

  $_safer_file_name = regsubst($name,'/','_','G')

  # Must come lexically after 10-table.conf
  file { "table-${tablename}.conf":
    ensure  => file,
    owner   => $collectd::config_owner,
    path    => "${collectd::plugin_conf_dir}/${collectd::plugin::table::order}-tabletable-${_safer_file_name}.conf",
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => epp('collectd/plugin/table.conf.epp', { 'tables' => { $tablename => $table } }),
    notify  => Service[$collectd::service_name],
  }
}
