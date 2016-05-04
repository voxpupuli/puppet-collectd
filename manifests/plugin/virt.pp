# https://collectd.org/wiki/index.php/Plugin:virt
class collectd::plugin::virt (
  $connection,
  $ensure           = 'present',
  $manage_package   = undef,
  $refresh_interval = undef,
  $domain           = undef,
  $block_device     = undef,
  $interface_device = undef,
  $ignore_selected  = undef,
  $hostname_format  = undef,
  $interface_format = undef,
  $interval         = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_string($connection)

  if $refresh_interval != undef { validate_re($refresh_interval, '^\d+$') }
  if $domain != undef           { validate_string($domain) }
  if $block_device != undef     { validate_string($block_device) }
  if $interface_device != undef { validate_string($interface_device) }
  if $ignore_selected != undef  { validate_bool($ignore_selected) }
  if $hostname_format != undef  { validate_string($hostname_format) }
  if $interface_format != undef { validate_string($interface_format) }

  if $::osfamily == 'RedHat' {
    if $_manage_package {
      package { 'collectd-virt':
        ensure => $ensure,
      }
    }
  }

  if versioncmp("${::collectd::collectd_version_real}", '5.5') >= 0 { # lint:ignore:only_variable_string
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
