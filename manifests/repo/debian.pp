class collectd::repo::debian {
  contain apt
  if $collectd::manage_package {
    Class['apt::update'] -> Package[$collectd::package_name]
  }

  if $collectd::ci_package_repo {
    apt::source { 'collectd-ci':
      location => 'https://pkg.ci.collectd.org/deb/',
      repos    => "collectd-${$collectd::ci_package_repo}",
      key      => {
        'id'     => 'F806817DC3F5EA417F9FA2963994D24FB8543576',
        'server' => $collectd::package_keyserver,
      },
    }
  } else {
    if $facts['os']['name'] == 'Debian' {
      warning('You\'re trying to use the Ubuntu PPA on a Debian Server, which may cause errors')
      warning('We recommend you to use the $ci_package_repo parameter if you want to use an upstream repo on Debian')
    } else {
      apt::source { 'ppa_collectd':
        location => 'http://ppa.launchpad.net/collectd/collectd-5.5/ubuntu',
        repos    => 'main',
        key      => {
          'id'     => '7543C08D555DC473B9270ACDAF7ECBB3476ACEB3',
          'server' => $collectd::package_keyserver,
        },
      }
    }
  }
}
