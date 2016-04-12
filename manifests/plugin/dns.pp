# Class: collectd::plugin::dns
#
class collectd::plugin::dns (
  $ensure                  = 'present',
  $ignoresource            = undef,
  $interface               = 'any',
  $interval                = undef,
  $manage_package          = undef,
  $package_name            = 'collectd-dns',
  $selectnumericquerytypes = true,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $_manage_package {
    package { 'collectd-dns':
      ensure => $ensure,
      name   => $package_name,
    }
  }

  validate_re($ensure,'^(present)|(absent)$',
    "collectd::plugin::dns::ensure is <${ensure}> and must be either 'present' or 'absent'.")

  if ( $ignoresource != undef ) and ( is_ip_address($ignoresource) == false ) {
    fail("collectd::plugin::dns::ignoresource is <${ignoresource}> and must be a valid IP address.")
  }

  validate_string($interface)

  if $interval != undef {
    validate_numeric($interval)
  }

  if is_string($selectnumericquerytypes) == true {
    $selectnumericquerytypes_real = str2bool($selectnumericquerytypes)
  } else {
    $selectnumericquerytypes_real = $selectnumericquerytypes
  }
  validate_bool($selectnumericquerytypes_real)

  collectd::plugin { 'dns':
    ensure   => $ensure,
    content  => template('collectd/plugin/dns.conf.erb'),
    interval => $interval,
  }
}
