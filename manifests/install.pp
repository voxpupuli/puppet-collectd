#
class collectd::install {

  assert_private()

  if $collectd::manage_package {
    package { $collectd::package_name:
      ensure          => $collectd::package_ensure,
      provider        => $collectd::package_provider,
      install_options => $collectd::package_install_options,
    }
  }
}
