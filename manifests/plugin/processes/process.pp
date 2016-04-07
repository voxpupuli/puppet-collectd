define collectd::plugin::processes::process (
  $process = $name,
  $ensure  = 'present'
) {

  include ::collectd::plugin::processes
  include ::collectd

  concat::fragment{ "collectd_plugin_processes_conf_process_${process}":
    order   => '50',
    content => "Process \"${process}\"\n",
    target  => "${collectd::plugin_conf_dir}/processes-config.conf",
  }

}
