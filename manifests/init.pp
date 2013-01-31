class collectd(
  $purge   = undef,
  $recurse = undef,
) {
  include collectd::params

  package { 'collectd':
    ensure   => installed,
    name     => $collectd::params::package,
    provider => $collectd::params::provider,
    before   => File['collectd.conf'],
  }


  # Where additional configurations are stored
  file { 'collectd.d':
    ensure  => directory,
    name    => $collectd::params::plugin_conf_dir,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    purge   => $purge,
    recurse => $recurse,
  }

  # Do not make modifications, but refresh the service
  # when the file is changed
  file { 'collectd.conf':
    notify  => Service['collectd'],
    path    => $collectd::params::config_file,
  }

  # Include conf_d directory
  file_line { 'include_conf_d':
    line    => "Include \"${collectd::params::plugin_conf_dir}/\"",
    path    => $collectd::params::config_file,
    notify  => Service['collectd'],
  }

  service { 'collectd':
    ensure    => running,
    name      => $collectd::params::service_name,
    enable    => true,
    require   => Package['collectd'],
  }
}
