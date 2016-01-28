define collectd::plugin::processes::processmatch (
  $regex,
  $ensure    = 'present',
  $matchname = $name
){

  include ::collectd::plugin::processes
  include ::collectd::params

  concat::fragment{"collectd_plugin_processes_conf_processmatch_${matchname}":
    ensure  => $ensure,
    order   => '51',
    content => "ProcessMatch \"${matchname}\" \"${regex}\"\n",
    target  => "${collectd::params::plugin_conf_dir}/processes-config.conf",
  }

}
