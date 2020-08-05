# Class: collectd::plugin::dns
#
class collectd::plugin::dns (
  Enum['present','absent'] $ensure                 = 'present',
  Optional[Stdlib::IP::Address] $ignoresource      = undef,
  String $interface                                = 'any',
  Optional[String] $interval                       = undef,
  $manage_package                                  = undef,
  $package_name                                    = 'collectd-dns',
  Variant[String,Boolean] $selectnumericquerytypes = true,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $_manage_package {
    package { 'collectd-dns':
      ensure => $ensure,
      name   => $package_name,
    }
  }

  collectd::plugin { 'dns':
    ensure   => $ensure,
    content  => template('collectd/plugin/dns.conf.erb'),
    interval => $interval,
  }
}
