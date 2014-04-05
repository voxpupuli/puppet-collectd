#
class collectd(
  $fqdnlookup   = true,
  $interval     = 10,
  $purge        = undef,
  $purge_config = false,
  $recurse      = undef,
  $threads      = 5,
  $timeout      = 2,
  $typesdb      = [],
  $version      = installed,
) {
  include collectd::params

  $plugin_conf_dir = $collectd::params::plugin_conf_dir
  validate_bool($purge_config, $fqdnlookup)
  validate_array($typesdb)

  package { 'collectd':
    ensure   => $version,
    name     => $collectd::params::package,
    provider => $collectd::params::provider,
    before   => File['collectd.conf', 'collectd.d'],
  }

  file { 'collectd.d':
    ensure  => directory,
    path    => $collectd::params::plugin_conf_dir,
    mode    => '0755',
    owner   => 'root',
    group   => $collectd::params::root_group,
    purge   => $purge,
    recurse => $recurse,
  }

  $conf_content = $purge_config ? {
    true    => template('collectd/collectd.conf.erb'),
    default => undef,
  }

  file { 'collectd.conf':
    path    => $collectd::params::config_file,
    content => $conf_content,
    notify  => Service['collectd'],
  }

  if $purge_config != true {
    # former include of conf_d directory
    file_line { 'include_conf_d':
      ensure  => absent,
      line    => "Include \"${collectd::params::plugin_conf_dir}/\"",
      path    => $collectd::params::config_file,
      notify  => Service['collectd'],
    }
    # include (conf_d directory)/*.conf
    file_line { 'include_conf_d_dot_conf':
      ensure  => present,
      line    => "Include \"${collectd::params::plugin_conf_dir}/*.conf\"",
      path    => $collectd::params::config_file,
      notify  => Service['collectd'],
    }
  }

  service { 'collectd':
    ensure    => running,
    name      => $collectd::params::service_name,
    enable    => true,
    require   => Package['collectd'],
  }
}
