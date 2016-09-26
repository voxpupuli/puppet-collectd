class collectd::install (
  $package_ensure          = $collectd::package_ensure,
  $package_name            = $collectd::package_name,
  $package_provider        = $collectd::package_provider,
  $package_install_options = $collectd::package_install_options,
  $manage_package          = $collectd::manage_package,
) {

  if $package_install_options != undef {
    validate_array($package_install_options)
  }

  if $manage_package {
    if !defined(Yum::Install['epel-release']) {
      if $::osfamily == 'RedHat' {
        yum::install { 'epel-release':
          ensure => 'present',
          source => "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${::operatingsystemmajrelease}.noarch.rpm",
        }
      }
    }

    package { $package_name:
      ensure          => $package_ensure,
      provider        => $package_provider,
      install_options => $package_install_options,
    }
  }
}
