# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_python
define collectd::plugin::python (
  $modulepath,
  $module,
  $script_source,
  $config = {},
) {
  include collectd::params

  validate_hash($config)

  $conf_dir = $collectd::params::plugin_conf_dir

  file {
    "${name}.load":
      path    => "${conf_dir}/${name}.conf",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0644',
      content => template('collectd/python.conf.erb'),
      notify  => Service['collectd'],
  }

  file {
    "${name}.script":
      path    => "${modulepath}/${module}.py",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0644',
      source  => $script_source,
      require => File["${name}.load"],
      notify  => Service['collectd'],
  }
}
