#
# @summary This define initialize a collectd typesdb file
#
# @param path File path
# @param group File
# @param mode File mode
# @param owner File owner
# @param include Include the file in the typesdb config (require collectd::purge_config at true)
#
define collectd::typesdb (
  String $path     = $title,
  String $group    = $collectd::config_group,
  String $mode     = $collectd::config_mode,
  String $owner    = $collectd::config_owner,
  Boolean $include = false,
) {
  include collectd

  concat { $path:
    ensure         => present,
    owner          => $owner,
    group          => $group,
    mode           => $mode,
    ensure_newline => true,
    notify         => Service[$collectd::service_name],
    require        => File['collectd.d'],
  }

  if $include and $collectd::purge_config {
    concat::fragment { "include_typedb_${path}":
      order   => '50',
      target  => 'collectd_typesdb',
      content => "TypesDB \"${path}\"\n",
    }
  }
}
