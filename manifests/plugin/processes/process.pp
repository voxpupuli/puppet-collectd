define collectd::plugin::processes::process (
  $process   = $name,
  $ensure    = 'present'
){

  include ::collectd::plugin::processes
  include ::collectd::params

  concat::fragment{"collectd_plugin_processes_conf_process_${process}":
    ensure  => $ensure,
    order   => '50',
    content => "Process \"${process}\"\n",
    target  => "${collectd::params::plugin_conf_dir}/processes-config.conf",
  }

}
