#
define collectd::plugin (
  $ensure = 'present',
) {

  include collectd::params

  $plugin = $name
  $conf_dir = $collectd::params::plugin_conf_dir

  file { "${plugin}.load":
    ensure  => $ensure,
    path    => "${conf_dir}/00-${plugin}.conf",
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "LoadPlugin ${plugin}\n",
    notify  => Service['collectd'],
  }

  # Older versions of this module didn't use the "00-" prefix.
  # Delete those potentially left over files just to be sure.
  file { "old_${plugin}.load":
    ensure  => absent,
    path    => "${conf_dir}/${plugin}.conf",
    notify  => Service['collectd'],
  }
}
