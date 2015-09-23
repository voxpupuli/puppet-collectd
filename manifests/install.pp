class collectd::install (
  $version          = $collectd::version,
  $package_name     = $collectd::package_name,
  $package_provider = $collectd::package_provider,
) {

  package { $package_name:
    ensure   => $version,
    name     => $package_name,
    provider => $package_provider,
  }

}
