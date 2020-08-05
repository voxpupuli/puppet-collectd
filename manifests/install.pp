# @summary installs collectd
# @api private
class collectd::install {
  assert_private()

  if $collectd::manage_package {
    package { $collectd::package_name:
      ensure          => $collectd::package_ensure,
      provider        => $collectd::package_provider,
      install_options => $collectd::package_install_options,
    }
  }

  if $collectd::utils and  ( $facts['os']['family'] == 'Debian' or ( $facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'],'8') >= 0 )) {
    package { 'collectd-utils':
      ensure => $collectd::package_ensure,
    }
  }
}
