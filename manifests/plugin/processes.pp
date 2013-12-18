# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_processes
class collectd::plugin::processes (
  $ensure          = present,
  $processes       = undef,
  $process_matches = undef,
) {
  include collectd::params

  if $processes { validate_array($processes) }
  if $process_matches { validate_array($process_matches) }

  $conf_dir = $collectd::params::plugin_conf_dir

  file {
    'processes.conf':
      ensure  => $ensure,
      path    => "${conf_dir}/processes.conf",
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('collectd/processes.conf.erb'),
      notify  => Service['collectd'],
  }
}
