# @summary installs and configures collectd
# @example Install collectd utilities
#  class{'collectd':
#    utils => true,
#  }
#
# @param utils Install collectd utilities package containing collectdctl, collectd-nagios
class collectd (
  Boolean $autoloadplugin                              = $collectd::params::autoloadplugin,
  String $collectd_hostname                            = $collectd::params::collectd_hostname,
  Optional[String] $conf_content                       = $collectd::params::conf_content,
  String $config_file                                  = $collectd::params::config_file,
  Boolean $fqdnlookup                                  = $collectd::params::fqdnlookup,
  Boolean $has_wordexp                                 = $collectd::params::has_wordexp,
  Array $include                                       = $collectd::params::include,
  Integer[1] $interval                                 = $collectd::params::interval,
  Boolean $internal_stats                              = $collectd::params::internal_stats,
  Boolean $manage_package                              = $collectd::params::manage_package,
  Boolean $manage_repo                                 = $collectd::params::manage_repo,
  Optional[Collectd::Manifests::Init] $ci_package_repo = $collectd::params::ci_package_repo,
  Boolean $manage_service                              = $collectd::params::manage_service,
  String $minimum_version                              = $collectd::params::minimum_version,
  String $package_ensure                               = $collectd::params::package_ensure,
  Optional[Array] $package_install_options             = $collectd::params::package_install_options,
  Stdlib::Fqdn $package_keyserver                      = $collectd::params::package_keyserver,
  Variant[String[1],Array[String[1]]] $package_name    = $collectd::params::package_name,
  Optional[String] $package_provider                   = $collectd::params::package_provider,
  Stdlib::Absolutepath $plugin_conf_dir                = $collectd::params::plugin_conf_dir,
  String $plugin_conf_dir_mode                         = $collectd::params::plugin_conf_dir_mode,
  Boolean $purge                                       = $collectd::params::purge,
  Boolean $purge_config                                = $collectd::params::purge_config,
  Integer[1] $read_threads                             = $collectd::params::read_threads,
  Boolean $recurse                                     = $collectd::params::recurse,
  String $config_group                                 = $collectd::params::config_group,
  String $config_mode                                  = $collectd::params::config_mode,
  String $config_owner                                 = $collectd::params::config_owner,
  Boolean $service_enable                              = $collectd::params::service_enable,
  String $service_ensure                               = $collectd::params::service_ensure,
  String $service_name                                 = $collectd::params::service_name,
  Integer[1] $timeout                                  = $collectd::params::timeout,
  Array $typesdb                                       = $collectd::params::typesdb,
  Optional[Integer] $write_queue_limit_high            = $collectd::params::write_queue_limit_high,
  Optional[Integer] $write_queue_limit_low             = $collectd::params::write_queue_limit_low,
  Integer[1] $write_threads                            = $collectd::params::write_threads,
  Boolean    $utils                                    = $collectd::params::utils,
) inherits collectd::params {
  $collectd_version_real = pick_default($facts['collectd_version'], $minimum_version)

  contain collectd::repo
  contain collectd::install
  contain collectd::config
  contain collectd::service

  Class['collectd::repo']
  ~> Class['collectd::install']
  -> Class['collectd::config']
  ~> Class['collectd::service']
}
