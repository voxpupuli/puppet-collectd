define collectd::plugin::exec::cmd (
  String $user,
  String $group,
  Array $exec              = [],
  Array $notification_exec = [],
) {
  include collectd
  include collectd::plugin::exec

  concat::fragment { "collectd_plugin_exec_conf_${title}":
    order   => '50', # somewhere between header and footer
    target  => $collectd::plugin::exec::exec_conf,
    content => template('collectd/plugin/exec/cmd.conf.erb'),
  }
}
