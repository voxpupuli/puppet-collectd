class collectd::repo::redhat {
  if $collectd::ci_package_repo {
    yumrepo { 'collectd-ci':
      ensure  => present,
      enabled => '1',
      baseurl => "https://pkg.ci.collectd.org/rpm/collectd-${collectd::ci_package_repo}/epel-${facts['os']['release']['major']}-${facts['os']['architecture']}",
      gpgkey  => 'https://pkg.ci.collectd.org/pubkey.asc',
    }
  } else {
    require epel
  }
}
