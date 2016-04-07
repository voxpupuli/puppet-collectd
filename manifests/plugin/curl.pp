#
class collectd::plugin::curl (
  $ensure = undef
  $manage_package = undef,
  $interval       = undef,
  $pages          = { },
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-curl':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'curl':
    ensure   => $ensure_real,
    interval => $interval,
  }
  $defaults = {
    'ensure' => $ensure_real,
  }
  create_resources(collectd::plugin::curl::page, $pages, $defaults)
}
