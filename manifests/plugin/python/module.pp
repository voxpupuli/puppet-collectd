# Single module definition
define collectd::plugin::python::module (
  Array $config                              = [],
  $ensure                                    = 'present',
  $module                                    = $title,
  $module_import                             = undef,
  Optional[Stdlib::Absolutepath] $modulepath = undef,
  $script_source                             = undef,
) {

  include collectd
  include collectd::plugin::python

  $module_dir = $modulepath ? {
    undef   => $collectd::python_dir,
    default => $modulepath
  }

  $_module_import = $module_import ? {
    undef   => $module,
    default => $module_import
  }

  if $script_source {
    file { "${module}.script":
      ensure  => $ensure,
      path    => "${module_dir}/${module}.py",
      owner   => $collectd::config_owner,
      group   => $collectd::config_group,
      mode    => $collectd::config_mode,
      source  => $script_source,
      require => File[$module_dir],
      notify  => Service[$collectd::service_name],
    }
  }
  $_python_module_conf = "${collectd::plugin_conf_dir}/${collectd::plugin::python::python_conf_dir}/${module}.conf"
  concat{$_python_module_conf:
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }

  concat::fragment{ "collectd_plugin_python_conf_${module}_header":
    order   => '00', # header
    target  => $_python_module_conf,
    content => template('collectd/plugin/python/module_header.conf.erb'),
  }
  concat::fragment{ "collectd_plugin_python_conf_${module}_footer":
    order   => '99', #  footer
    target  => $_python_module_conf,
    content => "   </Module>\n</Plugin>",
  }

}
