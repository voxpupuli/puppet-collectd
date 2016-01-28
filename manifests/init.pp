#
class collectd (
  $fqdnlookup              = $collectd::params::fqdnlookup,
  $collectd_hostname       = $collectd::params::collectd_hostname,
  $interval                = $collectd::params::interval,
  $include                 = $collectd::params::include,
  $internal_stats          = $collectd::params::internal_stats,
  $purge                   = $collectd::params::purge,
  $purge_config            = $collectd::params::purge_config,
  $recurse                 = $collectd::params::recurse,
  $threads                 = $collectd::params::threads,
  $timeout                 = $collectd::params::timeout,
  $typesdb                 = $collectd::params::typesdb,
  $write_queue_limit_high  = $collectd::params::write_queue_limit_high,
  $write_queue_limit_low   = $collectd::params::write_queue_limit_low,
  $config_file             = $collectd::params::config_file,
  $package_ensure          = $collectd::params::package_ensure,
  $package_provider        = $collectd::params::package_provider,
  $package_install_options = $collectd::params::package_install_options,
  $package_name            = $collectd::params::package_name,
  $plugin_conf_dir         = $collectd::params::plugin_conf_dir,
  $plugin_conf_dir_mode    = $collectd::params::plugin_conf_dir_mode,
  $root_group              = $collectd::params::root_group,
  $service_name            = $collectd::params::service_name,
  $service_ensure          = $collectd::params::service_ensure,
  $service_enable          = $collectd::params::service_enable,
  $minimum_version         = $collectd::params::minimum_version,
  $manage_package          = $collectd::params::manage_package,
) inherits collectd::params {

  validate_bool($purge_config, $fqdnlookup)
  validate_array($include, $typesdb)

  class { '::collectd::install':
    package_install_options => $package_install_options,
  }

  class { '::collectd::config': }

  class { '::collectd::service': }

  anchor {'collectd::begin': }
  anchor {'collectd::end': }

  Anchor['collectd::begin'] ->
  Class['collectd::install'] ->
  Class['collectd::config'] ~>
  Class['collectd::service']
}
