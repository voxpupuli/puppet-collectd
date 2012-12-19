class collectd {
  include collectd::params

  package { 'collectd':
    ensure   => installed,
    name     => $collectd::params::package,
    provider => $collectd::params::provider,
    before   => File['collectd.conf'],
  }

  file { $collectd::params::collectd_dir:
    ensure => directory,
  }

  # Where additional configurations are stored
  file { 'collectd.d':
    ensure => directory,
    name   => $collectd::params::plugin_conf_dir,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  # Do not make modifications, but refresh the service
  # when the file is changed
  file { 'collectd.conf':
    path      => "${collectd::params::plugin_conf_dir}/collectd.conf",
    require => File[$collectd::params::collectd_dir],
  }

  service { 'collectd':
    ensure    => running,
    name      => $collectd::params::service_name,
    enable    => true,
    subscribe => File['collectd.conf'],
    require   => Package['collectd'],
  }
}
