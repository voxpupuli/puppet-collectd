# Single module definition
define collectd::plugin::python::module (
  $config        = [],
  $ensure        = 'present',
  $module        = $title,
  $modulepath    = undef,
  $script_source = undef,
) {

  include ::collectd
  include ::collectd::plugin::python

  validate_array($config)

  $module_dir = $modulepath ? {
    undef   => $collectd::python_dir,
    default => $modulepath
  }
  validate_absolute_path($module_dir)

  if $script_source {
    file { "${module}.script":
      ensure  => $ensure,
      path    => "${module_dir}/${module}.py",
      owner   => 'root',
      group   => $collectd::root_group,
      mode    => '0640',
      source  => $script_source,
      require => File[$module_dir],
      notify  => Service['collectd'],
    }
  }

  concat::fragment{ "collectd_plugin_python_conf_${module}":
    order   => '50', # somewhere between header and footer
    target  => $collectd::plugin::python::python_conf,
    content => template('collectd/plugin/python/module.conf.erb'),
  }
}
