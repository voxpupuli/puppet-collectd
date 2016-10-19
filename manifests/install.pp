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
    if $::osfamily == 'RedHat' {
      if !defined(Yum::Install['epel-release']) {
        yum::install { 'epel-release':
          ensure => 'present',
          source => "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${::operatingsystemmajrelease}.noarch.rpm",
        }
      }

      Package[$package_name] {
        require => Yum::Install['epel-release']
      }
    }

    case $::operatingsystemmajrelease {
      '12.04', '14.04', '16.04' : {
        apt::source { 'ppa_collectd':
          location => 'http://ppa.launchpad.net/collectd/collectd-5.5/ubuntu',
          repos    => 'main',
          key      => {
            'id'     => '7543C08D555DC473B9270ACDAF7ECBB3476ACEB3',
            'server' => 'keyserver.ubuntu.com',
          },
        }
      }
      default                   : {
      }
    }

    package { $package_name:
      ensure          => $package_ensure,
      provider        => $package_provider,
      install_options => $package_install_options,
    }
  }
}
