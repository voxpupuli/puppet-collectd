# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_python
class collectd::plugin::python (
  $ensure = present,
  $interval = undef,
) {
  require collectd::params

  if (
      $::osfamily == 'Redhat' and
      operatingsystemmajrelease < 7
  ) {
      ensure_packages('collectd-python')
  }

  $conf_dir = $collectd::params::plugin_conf_dir
  $modulepath = $collectd::params::python_dir

  # This is deprecated file naming ensuring old style file removed, and should be removed in next major relese
  file { "${name}.load-deprecated":
    ensure => absent,
    path   => "${conf_dir}/${name}.conf",
  }
  # End deprecation

  $ensure_modulepath = $ensure ? {
      'absent' => $ensure,
      default  => 'directory',
  }

  file { $modulepath :
      ensure  => $ensure_modulepath,
      mode    => '0755',
      owner   => root,
      group   => root,
      require => Package[$collectd::params::package]
  }

  collectd::plugin { 'python' :
      ensure   => $ensure,
      interval => $interval,
      globals  => true,
  }

  concat { "${conf_dir}/python-modules.conf" :
      ensure => $ensure,
      notify => Service['collectd']
  }

  concat::fragment { 'python-modules.conf-head' :
      target  => "${conf_dir}/python-modules.conf",
      order   => 01,
      content => template('collectd/python-modules.conf-head.erb')
  }
  concat::fragment { 'python-modules.conf-end' :
      target  => "${conf_dir}/python-modules.conf",
      order   => 99,
      content => "</Plugin>\n"
  }
  
}
