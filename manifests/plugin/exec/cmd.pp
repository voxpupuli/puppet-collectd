define collectd::plugin::exec::cmd (
  $user,
  $group,
  $exec              = [],
  $notification_exec = [],
  $script_source     = undef,
  $extra_param       = undef,
  $module            = $title,
  $ensure            = present,
) {
  include collectd::params
  include collectd::plugin::exec

  validate_array($exec)
  validate_array($notification_exec)

  $conf_dir = $collectd::params::plugin_conf_dir

  # This is deprecated file naming ensuring old style file removed, and should be removed in next major relese
  file { "${name}.load-deprecated":
    ensure => absent,
    path   => "${conf_dir}/${name}.conf",
  }
  # End deprecation

  if $script_source {
    file { "${module}.script":
      ensure  => $ensure,
      path    => "${conf_dir}/${module}.sh",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0755',
      source  => $script_source,
      require => File[$conf_dir],
      notify  => Service['collectd'],
    }
  }

  concat::fragment{"collectd_plugin_exec_conf_${title}":
    ensure  => $ensure,
    order   => '50', # somewhere between header and footer
    target  => $collectd::plugin::exec::exec_conf,
    content => template('collectd/plugin/exec/cmd.conf.erb'),
  }
}
