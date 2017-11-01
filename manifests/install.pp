class collectd::install (
  $package_ensure                           = $collectd::package_ensure,
  $package_name                             = $collectd::package_name,
  $package_provider                         = $collectd::package_provider,
  Optional[Array] $package_install_options  = $collectd::package_install_options,
  $manage_package                           = $collectd::manage_package,
) {

  if $manage_package {
    package { $package_name:
      ensure          => $package_ensure,
      provider        => $package_provider,
      install_options => $package_install_options,
    }
  }
}
