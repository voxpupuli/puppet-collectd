# collectd::repo
# Handle package repo configuration
class collectd::repo {

  if $collectd::manage_repo {
    if $::collectd::ci_package_repo != undef {
      validate_re($::collectd::ci_package_repo, [ '^5.4', '^5.5', '^5.6', '5.7', '^master' ], "ci_package_repo has to match '5.4', '5.5', '5.6', '5.7' or 'master' (RC for next release), got: ${::collectd::ci_package_repo}")
    }

    $osfamily_downcase = downcase($::osfamily)

    if defined("::collectd::repo::${osfamily_downcase}") {
      include "::collectd::repo::${osfamily_downcase}"
    } else {
      notify{"You have asked to manage_repo on a system that doesn't have a repo class specified: ${::osfamily}":}
    }
  }

}

