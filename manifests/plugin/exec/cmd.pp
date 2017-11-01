define collectd::plugin::exec::cmd (
  $user,
  $group,
  Array $exec              = [],
  Array $notification_exec = [],
  $ensure                  = 'present',
) {

  include ::collectd
  include ::collectd::plugin::exec

  $conf_dir = $collectd::plugin_conf_dir

  # This is deprecated file naming ensuring old style file removed, and should be removed in next major relese
  file { "${name}.load-deprecated":
    ensure => absent,
    path   => "${conf_dir}/${name}.conf",
  }
  # End deprecation

  concat::fragment{ "collectd_plugin_exec_conf_${title}":
    order   => '50', # somewhere between header and footer
    target  => $collectd::plugin::exec::exec_conf,
    content => template('collectd/plugin/exec/cmd.conf.erb'),
  }
}
