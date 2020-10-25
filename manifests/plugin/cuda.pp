# Class: collectd::plugin::cuda
#
# @see https://pypi.python.org/pypi/collectd-cuda
#
#  Configures cuda metrics collection. Optionally installs the plugin
#  Note, it is up to you to support package installation and sources
#
# @param ensure Optional[String] Passed to package and collectd::plugin resources (both). Default: present
# @param manage_package Optional[Boolean] Toggles installation of plugin. Default: undef
# @param package_name Optional[String] Name of plugin package to install. Default: collectd-cuda
# @param package_provider Optional[String] Passed to package resource. Default: pip
# @param provider_proxy Optional[String] Proxy for provider. Default: undef
class collectd::plugin::cuda (
  Optional[String] $ensure           = 'present',
  Optional[Boolean] $manage_package  = undef,
  Optional[String] $package_name     = 'collectd-cuda',
  Optional[String] $package_provider = undef,
  Optional[String] $provider_proxy   = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)
  if $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '8' {
    $_python_pip_package = 'python3-pip'
    if $package_provider =~ Undef {
      $_package_provider = 'pip3'
    }
    else {
      $_package_provider = $package_provider
    }
  } else {
    $_python_pip_package = 'python-pip'
    if $package_provider =~ Undef {
      $_package_provider = 'pip'
    }
    else {
      $_package_provider = $package_provider
    }
  }

  if ($_manage_package) {
    if (!defined(Package[$_python_pip_package])) {
      package { $_python_pip_package: ensure => 'present', }

      Package[$package_name] {
        require => Package[$_python_pip_package],
      }

      if $facts['os']['family'] == 'RedHat' {
        # Epel is installed in install.pp if manage_repo is true
        # python-pip doesn't exist in base for RedHat. Need epel installed first
        if (defined(Class['epel'])) {
          Package[$_python_pip_package] {
            require => Class['epel'],
          }
        }
      }
    }
  }

  if ($_manage_package) and ($provider_proxy) {
    $install_options = [{ '--proxy' => $provider_proxy }]
  } else {
    $install_options = undef
  }

  package { $package_name:
    ensure          => $ensure,
    provider        => $_package_provider,
    install_options => $install_options,
  }

  collectd::plugin::python::module { 'collectd_cuda.collectd_plugin':
    ensure => $ensure,
  }
}
