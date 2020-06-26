#
class collectd::plugin::curl (
  $ensure         = 'present',
  $interval       = undef,
  $manage_package = undef,
  $pages          = { }
) {

  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-curl':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'curl':
    ensure   => $ensure,
    interval => $interval,
  }

  $defaults = {
    'ensure' => $ensure,
  }

  $pages.each |String $resource, Hash $attributes| {
    collectd::plugin::curl::page { $resource:
      * => $defaults + $attributes,
    }
  }
}
