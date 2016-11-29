#
class collectd (
  $collectd_hostname       = $collectd::params::collectd_hostname,
  $conf_content            = $collectd::params::conf_content,
  $config_file             = $collectd::params::config_file,
  $fqdnlookup              = $collectd::params::fqdnlookup,
  $has_wordexp             = $collectd::params::has_wordexp,
  $include                 = $collectd::params::include,
  $interval                = $collectd::params::interval,
  $internal_stats          = $collectd::params::internal_stats,
  $manage_package          = $collectd::params::manage_package,
  $manage_repo             = $collectd::params::manage_repo,
  $ci_package_repo         = $collectd::params::ci_package_repo,
  $manage_service          = $collectd::params::manage_service,
  $minimum_version         = $collectd::params::minimum_version,
  $package_ensure          = $collectd::params::package_ensure,
  $package_install_options = $collectd::params::package_install_options,
  $package_name            = $collectd::params::package_name,
  $package_provider        = $collectd::params::package_provider,
  $plugin_conf_dir         = $collectd::params::plugin_conf_dir,
  $plugin_conf_dir_mode    = $collectd::params::plugin_conf_dir_mode,
  $purge                   = $collectd::params::purge,
  $purge_config            = $collectd::params::purge_config,
  $read_threads            = $collectd::params::read_threads,
  $recurse                 = $collectd::params::recurse,
  $root_group              = $collectd::params::root_group,
  $service_enable          = $collectd::params::service_enable,
  $service_ensure          = $collectd::params::service_ensure,
  $service_name            = $collectd::params::service_name,
  $timeout                 = $collectd::params::timeout,
  $typesdb                 = $collectd::params::typesdb,
  $write_queue_limit_high  = $collectd::params::write_queue_limit_high,
  $write_queue_limit_low   = $collectd::params::write_queue_limit_low,
  $write_threads           = $collectd::params::write_threads,
) inherits collectd::params {

  $collectd_version_real = pick($::collectd_version, $minimum_version)

  class { '::collectd::install':
    package_install_options => $package_install_options,
  }

  class { '::collectd::repo': }

  class { '::collectd::config': }

  class { '::collectd::service': }

  anchor { 'collectd::begin': }
  anchor { 'collectd::end': }

  Class['::collectd::repo'] ~>
  Class['::collectd::install']

  Anchor['collectd::begin'] ->
  Class['collectd::install'] ->
  Class['collectd::config'] ~>
  Class['collectd::service']
}
