class collectd::repo::redhat {

  if $::collectd::ci_package_repo {

    yumrepo { 'collectd-ci':
      ensure  => present,
      enabled => '1',
      baseurl => "https://pkg.ci.collectd.org/rpm/collectd-${::collectd::ci_package_repo}/epel-${::operatingsystemmajrelease}-${::architecture}",
      gpgkey  => 'https://pkg.ci.collectd.org/pubkey.asc',
    }

  } else {

    # TODO: Replace this with EPEL module requirement in Major version bump

    if !defined(Yum::Install['epel-release']) {
      yum::install { 'epel-release':
        ensure => 'present',
        source => "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${::operatingsystemmajrelease}.noarch.rpm",
        before => Package[$::collectd::package_name],
      }
    }


  }

}
