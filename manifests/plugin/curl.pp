#
class collectd::plugin::curl (
  $ensure = present,
  $pages  = { },
) {
  collectd::plugin {'curl': }
  create_resources(collectd::plugin::curl::page, $pages)
}
