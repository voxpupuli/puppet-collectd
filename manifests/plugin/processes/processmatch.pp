define collectd::plugin::processes::processmatch (
  $regex,
  $ensure    = 'present',
  $matchname = $name
) {

  include ::collectd::plugin::processes
  include ::collectd

  concat::fragment{ "collectd_plugin_processes_conf_processmatch_${matchname}":
    order   => '51',
    content => "ProcessMatch \"${matchname}\" \"${regex}\"\n",
    target  => "${collectd::plugin_conf_dir}/processes-config.conf",
  }
}
