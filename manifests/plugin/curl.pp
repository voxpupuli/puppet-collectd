#
class collectd::plugin::curl (
  $ensure         = present,
  $manage_package = $collectd::manage_package,
  $interval       = undef,
  $pages          = { },
) {

  if $::osfamily == 'Redhat' {
    if $manage_package {
      package { 'collectd-curl':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin {'curl':
    ensure   => $ensure,
    interval => $interval,
  }
  $defaults = {
    'ensure' => $ensure,
  }
  create_resources(collectd::plugin::curl::page, $pages, $defaults)
}
