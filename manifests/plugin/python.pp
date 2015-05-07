# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_python
class collectd::plugin::python (
  $modulepaths = [],
  $ensure      = present,
  $modules     = {},
  # Unlike most other plugins, this one should set "Globals true". This will cause collectd
  # to export the name of all objects in the Python interpreter for all plugins to see.
  $globals     = true,
  $order       = '10',
  $interval    = undef,
  # Python 2 defaults to 'ascii' and Python 3 to 'utf-8'
  $encoding    = undef,
  $interactive = false,
  $logtraces   = false,
) {
  include collectd::params

  validate_hash($modules)
  validate_bool($interactive)
  validate_bool($logtraces)
  validate_bool($globals)
  validate_array($modulepaths)

  $module_dirs = empty($modulepaths) ? {
    true  => [$collectd::params::python_dir],
    # use paths provided by the user
    false => $modulepaths
  }

  collectd::plugin {'python':
    ensure   => $ensure,
    interval => $interval,
    order    => $order,
    globals  => $globals,
  }

  $ensure_modulepath = $ensure ? {
    'absent' => $ensure,
    default  => 'directory',
  }

  ensure_resource('file', $module_dirs,
    {
      'ensure'  => $ensure_modulepath,
      'mode'    => '0750',
      'owner'   => 'root',
      'group'   => $collectd::params::root_group,
      'require' => Package[$collectd::params::package]
    }
  )

  # should be loaded after global plugin configuration
  $python_conf = "${collectd::params::plugin_conf_dir}/python-config.conf"

  concat{ $python_conf:
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::params::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }

  concat::fragment{'collectd_plugin_python_conf_header':
    order   => '00',
    content => template('collectd/plugin/python/header.conf.erb'),
    target  => $python_conf,
  }

  concat::fragment{'collectd_plugin_python_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => $python_conf,
  }

  $defaults = {
    'ensure'     => $ensure,
    'modulepath' => $module_dirs[0],
  }
  create_resources(collectd::plugin::python::module, $modules, $defaults)
}
