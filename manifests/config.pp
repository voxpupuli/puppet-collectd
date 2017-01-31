# private
class collectd::config (
  $collectd_hostname      = $collectd::collectd_hostname,
  $config_file            = $collectd::config_file,
  $conf_content           = $collectd::conf_content,
  $fqdnlookup             = $collectd::fqdnlookup,
  $has_wordexp            = $collectd::has_wordexp,
  $include                = $collectd::include,
  $internal_stats         = $collectd::internal_stats,
  $interval               = $collectd::interval,
  $plugin_conf_dir        = $collectd::plugin_conf_dir,
  $plugin_conf_dir_mode   = $collectd::plugin_conf_dir_mode,
  $recurse                = $collectd::recurse,
  $root_group             = $collectd::root_group,
  $purge                  = $collectd::purge,
  $purge_config           = $collectd::purge_config,
  $read_threads           = $collectd::read_threads,
  $timeout                = $collectd::timeout,
  $typesdb                = $collectd::typesdb,
  $write_queue_limit_high = $collectd::write_queue_limit_high,
  $write_queue_limit_low  = $collectd::write_queue_limit_low,
  $write_threads          = $collectd::write_threads,
) {

  validate_absolute_path($config_file)
  validate_bool($fqdnlookup)
  validate_bool($has_wordexp)
  validate_array($include)
  validate_bool($internal_stats)
  validate_integer($interval)
  validate_absolute_path($plugin_conf_dir)
  validate_bool($purge_config)
  validate_integer($read_threads)
  validate_integer($timeout)
  validate_array($typesdb)
  validate_integer($write_threads)

  $_conf_content = $purge_config ? {
    true    => template('collectd/collectd.conf.erb'),
    default => $conf_content,
  }

  file { 'collectd.conf':
    path    => $config_file,
    content => $_conf_content,
  }

  if $purge_config != true and !$_conf_content {
    # former include of conf_d directory
    file_line { 'include_conf_d':
      ensure => absent,
      line   => "Include \"${plugin_conf_dir}/\"",
      path   => $config_file,
    }
    # include (conf_d directory)/*.conf
    file_line { 'include_conf_d_dot_conf':
      ensure => present,
      line   => "Include \"${plugin_conf_dir}/*.conf\"",
      path   => $config_file,
    }
  }

  file { 'collectd.d':
    ensure  => directory,
    path    => $plugin_conf_dir,
    mode    => $plugin_conf_dir_mode,
    owner   => 'root',
    group   => $root_group,
    purge   => $purge,
    recurse => $recurse,
  }

  File['collectd.d'] -> Concat <| tag == 'collectd' |>

}
