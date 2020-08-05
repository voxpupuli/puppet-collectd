# collectd::repo
# Handle package repo configuration
class collectd::repo {
  if $collectd::manage_repo {
    $osfamily_downcase = downcase($facts['os']['family'])

    if defined("::collectd::repo::${osfamily_downcase}") {
      require "::collectd::repo::${osfamily_downcase}"
    } else {
      notify { "You have asked to manage_repo on a system that doesn't have a repo class specified: ${facts['os']['family']}": }
    }
  }
}
