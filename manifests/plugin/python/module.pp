# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_python
define collectd::plugin::python::module (
  $script_source,
  $module = $name,
  $ensure = present,
  $config = {},
  $order = '10',
) {
  require collectd::params
  include collectd::plugin::python

  validate_hash($config)

  $conf_dir = $collectd::params::plugin_conf_dir
  $modulepath = $collectd::params::python_dir

  concat::fragment {
    "python-${name}.concat":
      target  => "${conf_dir}/python-modules.conf",
      content => template('collectd/python-modules-config-fragment.erb'),
      order   => 10,
  }


  file {
    "${name}.script":
      ensure  => $ensure,
      path    => "${modulepath}/${module}.py",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0640',
      source  => $script_source,
      require => [
          Concat["${conf_dir}/python-modules.conf"],
          Concat::Fragment["python-${name}.concat"]
          ],
      notify  => Service['collectd'],
  }
}
