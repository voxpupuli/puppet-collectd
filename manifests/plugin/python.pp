# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_python
class collectd::plugin::python (
  # Python 2 defaults to 'ascii' and Python 3 to 'utf-8'
  $encoding            = undef,
  $ensure              = 'present',
  # Unlike most other plugins, this one should set "Globals true". This will cause collectd
  # to export the name of all objects in the Python interpreter for all plugins to see.
  Boolean $globals     = true,
  Boolean $interactive = false,
  $interval            = undef,
  Boolean $logtraces   = false,
  $manage_package      = undef,
  Array $modulepaths   = [],
  Hash $modules        = {},
  $order               = '10',
  $conf_name           = 'python-config.conf',
) {
  include collectd

  $module_dirs = empty($modulepaths) ? {
    true  => [$collectd::python_dir],
    # use paths provided by the user
    false => $modulepaths
  }

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $ensure == 'present' {
    $ensure_real = $collectd::package_ensure
  } elsif $ensure == 'absent' {
    $ensure_real = 'absent'
  }

  if $facts['os']['name'] == 'Amazon' or
  ($facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'],'8') >= 0) {
    if $_manage_package {
      package { 'collectd-python':
        ensure => $ensure_real,
      }
      if (defined(Class['epel'])) {
        Package['collectd-python'] {
          require => Class['epel'],
        }
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
      'mode'    => $collectd::plugin_conf_dir_mode,
      'owner'   => $collectd::config_owner,
      'purge'   => $collectd::purge_config,
      'force'   => true,
      'group'   => $collectd::config_group,
      'require' => Package[$collectd::package_name]
    }
  )

  # should be loaded after global plugin configuration
  $python_conf = "${collectd::plugin_conf_dir}/${conf_name}"

  concat { $python_conf:
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
    require        => File['collectd.d'],
  }

  concat::fragment { 'collectd_plugin_python_conf_header':
    order   => '00',
    content => epp('collectd/plugin/python/header.conf.epp'),
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

  $modules.each |String $resource, Hash $attributes| {
    collectd::plugin::python::module { $resource:
      * => $defaults + $attributes,
    }
  }
}
