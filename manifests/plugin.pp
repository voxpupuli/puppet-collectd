#
define collectd::plugin (
  $ensure   = 'present',
  $content  = undef,
  $order    = '10',
  $globals  = false,
  $interval = undef,
  $plugin   = $name,
  Optional[Integer] $flushinterval = undef,
) {
  include collectd

  $conf_dir = $collectd::plugin_conf_dir
  $config_group = $collectd::config_group

  $plugin_package = "collectd-${plugin}"
  $flush_require = defined(Package[$plugin_package]) ? {
    true    => Package[$plugin_package],
    default => undef
  }

  file { "${plugin}.load":
    ensure  => $ensure,
    path    => "${conf_dir}/${order}-${plugin}.conf",
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => template('collectd/loadplugin.conf.erb'),
    notify  => Service[$collectd::service_name],
  }

  # Older versions of this module didn't use the "00-" prefix.
  # Delete those potentially left over files just to be sure.
  file { "older_${plugin}.load":
    ensure  => absent,
    path    => "${conf_dir}/${plugin}.conf",
    notify  => Service[$collectd::service_name],
    require => $flush_require,
  }

  # Older versions of this module use the "00-" prefix by default.
  # Delete those potentially left over files just to be sure.
  if $order != '00' {
    file { "old_${plugin}.load":
      ensure  => absent,
      path    => "${conf_dir}/00-${plugin}.conf",
      notify  => Service[$collectd::service_name],
      require => $flush_require,
    }
  }

  # Delete default config file created by platform packaging and not matching
  # plugin name
  if ($plugin in $collectd::package_configs) {
    file { "package_${plugin}.load":
      ensure  => absent,
      path    => "${conf_dir}/${collectd::package_configs[$plugin]}",
      notify  => Service[$collectd::service_name],
      require => $flush_require,
    }
  }
}
