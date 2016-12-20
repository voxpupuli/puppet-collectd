# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_python
class collectd::plugin::python (
  # Python 2 defaults to 'ascii' and Python 3 to 'utf-8'
  $encoding       = undef,
  $ensure         = 'present',
  # Unlike most other plugins, this one should set "Globals true". This will cause collectd
  # to export the name of all objects in the Python interpreter for all plugins to see.
  $globals        = true,
  $interactive    = false,
  $interval       = undef,
  $logtraces      = false,
  $manage_package = undef,
  $modulepaths    = [],
  $modules        = {},
  $order          = '10',
) {

  include ::collectd

  validate_hash($modules)
  validate_bool($interactive)
  validate_bool($logtraces)
  validate_bool($globals)
  validate_array($modulepaths)

  $module_dirs = empty($modulepaths) ? {
    true  => [$collectd::python_dir],
    # use paths provided by the user
    false => $modulepaths
  }

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $ensure == 'present' {
    $ensure_real = $::collectd::package_ensure
  } elsif $ensure == 'absent' {
    $ensure_real = 'absent'
  }

  if $::operatingsystem == 'Fedora' {
    if $_manage_package {
      package { 'collectd-python':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'python':
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
      'mode'    => '0755',
      'owner'   => 'root',
      'purge'   => $::collectd::purge_config,
      'force'   => true,
      'group'   => $collectd::root_group,
      'require' => Package[$collectd::package_name]
    }
  )

  # should be loaded after global plugin configuration
  $python_conf = "${collectd::plugin_conf_dir}/python-config.conf"

  concat { $python_conf:
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
    require        => File['collectd.d'],
  }

  concat::fragment { 'collectd_plugin_python_conf_header':
    order   => '00',
    content => template('collectd/plugin/python/header.conf.erb'),
    target  => $python_conf,
  }

  concat::fragment { 'collectd_plugin_python_conf_footer':
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
