# https://collectd.org/wiki/index.php/Plugin:virt
class collectd::plugin::virt (
  String $connection,
  $ensure                                                                    = 'present',
  $manage_package                                                            = undef,
  Optional[Pattern[/^\d+$/]] $refresh_interval                               = undef,
  Optional[String] $domain                                                   = undef,
  Optional[String] $block_device                                             = undef,
  Optional[String] $interface_device                                         = undef,
  Optional[Boolean] $ignore_selected                                         = undef,
  Optional[Enum['none', 'name', 'uuid', 'metadata']] $plugin_instance_format = undef,
  Optional[String] $hostname_format                                          = undef,
  Optional[String] $interface_format                                         = undef,
  Optional[String] $extra_stats                                              = undef,
  $interval                                                                  = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-virt':
        ensure => $ensure,
      }
    }
  }

  if versioncmp("${collectd::collectd_version_real}", '5.5') >= 0 { # lint:ignore:only_variable_string
    $plugin_name = 'virt'
  } else {
    $plugin_name = 'libvirt'
  }

  collectd::plugin { 'virt':
    ensure   => $ensure,
    name     => $plugin_name,
    content  => template('collectd/plugin/virt.conf.erb'),
    interval => $interval,
  }
}
