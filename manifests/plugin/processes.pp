# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_processes
class collectd::plugin::processes (
  $ensure          = present,
  $processes       = undef,
  $process_matches = undef,
) {
  if $processes { validate_array($processes) }
  if $process_matches { validate_array($process_matches) }

  collectd::plugin {'processes':
    ensure  => $ensure,
    content => template('collectd/plugin/processes.conf.erb'),
  }
}
