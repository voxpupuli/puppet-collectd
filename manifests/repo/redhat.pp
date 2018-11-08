class collectd::repo::redhat {

  if $::collectd::ci_package_repo {

    # Fix for issue #653
    if $::collectd::ci_package_repo != 'master' {
      $path_prefix = 'collectd-'
    } else {
      $path_prefix = ''
    }

    yumrepo { 'collectd-ci':
      ensure  => present,
      enabled => '1',
      baseurl => "https://pkg.ci.collectd.org/rpm/${path_prefix}${::collectd::ci_package_repo}/epel-${::operatingsystemmajrelease}-${::architecture}",
      gpgkey  => 'https://pkg.ci.collectd.org/pubkey.asc',
    }

  } else {
    require ::epel
  }

}
