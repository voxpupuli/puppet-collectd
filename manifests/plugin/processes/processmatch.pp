define collectd::plugin::processes::processmatch (
  $regex,
  $ensure    = 'present',
  $matchname = $name,
  Optional[Boolean] $collect_context_switch  = undef,
  Optional[Boolean] $collect_file_descriptor = undef,
  Optional[Boolean] $collect_memory_maps     = undef,
) {
  include collectd::plugin::processes
  include collectd

  concat::fragment { "collectd_plugin_processes_conf_processmatch_${matchname}":
    order   => '51',
    content => epp('collectd/plugin/processes/processmatch.conf.epp', {
        'matchname'               => $matchname,
        'regex'                   => $regex,
        'collect_context_switch'  => $collect_context_switch,
        'collect_file_descriptor' => $collect_file_descriptor,
        'collect_memory_maps'     => $collect_memory_maps,
    }),
    target  => "${collectd::plugin_conf_dir}/processes_config.conf",
  }
}
