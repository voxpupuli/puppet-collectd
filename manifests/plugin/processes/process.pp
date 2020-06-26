define collectd::plugin::processes::process (
  String $process                            = $name,
  Enum['present', 'absent'] $ensure          = 'present',
  Optional[Boolean] $collect_context_switch  = undef,
  Optional[Boolean] $collect_file_descriptor = undef,
  Optional[Boolean] $collect_memory_maps     = undef,
) {
  include collectd::plugin::processes
  include collectd

  concat::fragment { "collectd_plugin_processes_conf_process_${process}":
    order   => '50',
    content => epp('collectd/plugin/processes/process.conf.epp', {
        'process'                 => $process,
        'collect_context_switch'  => $collect_context_switch,
        'collect_file_descriptor' => $collect_file_descriptor,
        'collect_memory_maps'     => $collect_memory_maps,
    }),
    target  => "${collectd::plugin_conf_dir}/processes_config.conf",
  }
}
