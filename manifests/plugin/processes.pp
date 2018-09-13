# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_processes
class collectd::plugin::processes (
  Enum['present', 'absent'] $ensure          = 'present',
  Integer $order                             = 10,
  Optional[Numeric] $interval                = undef,
  Optional[Array] $processes                 = undef,
  Optional[Array] $process_matches           = undef,
  Optional[Boolean] $collect_context_switch  = undef,
  Optional[Boolean] $collect_file_descriptor = undef,
  Optional[Boolean] $collect_memory_maps     = undef,
) {

  include ::collectd

  collectd::plugin { 'processes':
    ensure   => $ensure,
    order    => $order,
    interval => $interval,
  }

  concat { "${collectd::plugin_conf_dir}/processes-config.conf":
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }
  concat::fragment { 'collectd_plugin_processes_conf_header':
    order   => '00',
    content => epp('collectd/plugin/processes-header.conf.epp'),
    target  => "${collectd::plugin_conf_dir}/processes-config.conf",
  }

  concat::fragment { 'collectd_plugin_processes_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::plugin_conf_dir}/processes-config.conf",
  }

  $defaults = { 'ensure' => $ensure }

  if $processes {
    $process_resources = collectd_convert_processes($processes)
    create_resources(
      collectd::plugin::processes::process,
      $process_resources,
      $defaults,
    )

  }
  if $process_matches {
    $process_matches_resources = collectd_convert_processes($process_matches)
    create_resources(
      collectd::plugin::processes::processmatch,
      $process_matches_resources,
      $defaults
    )
  }
}
