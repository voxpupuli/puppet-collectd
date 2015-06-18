# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_processes
class collectd::plugin::processes (
  $ensure          = present,
  $interval        = undef,
  $processes       = undef,
  $process_matches = undef,
) {
  if $processes { validate_array($processes) }
  if $process_matches { validate_array($process_matches) }

  collectd::plugin {'processes':
    ensure   => $ensure,
  }

  concat{"${collectd::params::plugin_conf_dir}/processes-config.conf":
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::params::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }
  concat::fragment{'collectd_plugin_processes_conf_header':
    ensure  => $ensure,
    order   => '00',
    content => '<Plugin processes>',
    target  => "${collectd::params::plugin_conf_dir}/processes-config.conf",
  }
  concat::fragment{'collectd_plugin_processes_conf_footer':
    ensure  => $ensure,
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::params::plugin_conf_dir}/processes-config.conf",
  }


  if $processes {
    collectd::plugin::processes::process { $processes : }
  }
  if $process_matches {
    $process_matches_resources = collectd_convert_processmatch($process_matches)
    $defaults = { 'ensure' => $ensure }
    create_resources(
      collectd::plugin::processes::processmatch,
      $process_matches_resources,
      $defaults
    )
  }

}
