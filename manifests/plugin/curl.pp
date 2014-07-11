#
class collectd::plugin::curl (
  $ensure = present,
  $pages  = { },
) {
  collectd::plugin {'curl':
    ensure => $ensure,
  }
  $defaults = {
    'ensure' => $ensure
  }
  create_resources(collectd::plugin::curl::page, $pages, $defaults)
}
