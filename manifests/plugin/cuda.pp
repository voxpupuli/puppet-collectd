# cuda plugin
# https://pypi.python.org/pypi/collectd-cuda
#
# == Class collectd::plugin::cuda
#
#  Configures cuda metrics collection. Optionally installs the plugin
#  Note, it is up to you to support package installation and sources
#
# === Parameters:
# [*ensure*]
#   String
#   Passed to package and collectd::plugin resources ( both )
#   Default: present
#
# [*interval*]
#   Integer
#   Interval setting for the plugin
#   Default: undef
#
# [*manage_package*]
#   Boolean
#   Toggles installation of plugin
#   Default: undef
#
# [*package_provider*]
#   String
#   Passed to package resource
#   Default: pip
#
#
class collectd::plugin::cuda (
  $ensure           = 'present',
  $interval         = undef,
  $manage_package   = undef,
  $package_name     = 'collectd-cuda',
  $package_provider = 'pip',
  $provider_proxy   = undef,
  $custom_types_db  = undef,
) {
  include ::collectd

  validate_string($ensure)

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if ($_manage_package) {
    if (!defined(Package['python-pip'])) {
      package { 'python-pip': ensure => 'present', }

      Package[$package_name] {
        require => Package['python-pip'],
      }

      if $::osfamily == 'RedHat' {
        # Epel is installed in install.pp if manage_repo is true
        # python-pip doesn't exist in base for RedHat. Need epel installed first
        if (defined(Yum::Install['epel-release'])) {
          Package['python-pip'] {
            require => Yum::Install['epel-release'],
          }
        }
      }
    }
  }

  if ($_manage_package) and ($provider_proxy) {
    $install_options = [{'--proxy' => $provider_proxy}]
  } else {
    $install_options = undef
  }

  package { $package_name:
    ensure          => $ensure,
    provider        => $package_provider,
    install_options => $install_options,
  }

  collectd::plugin::python::module { 'collectd_cuda.collectd_plugin':
    ensure => $ensure,
  }
}
