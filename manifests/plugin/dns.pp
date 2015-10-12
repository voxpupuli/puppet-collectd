# Class: collectd::plugin::dns
#
class collectd::plugin::dns (
  $ensure                  = 'present',
  $ignoresource            = undef,
  $interface               = 'any',
  $interval                = undef,
  $manage_package          = false,
  $package_name            = 'USE_DEFAULTS',
  $selectnumericquerytypes = true,
) {

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

  if is_string($manage_package) == true {
    $manage_package_real = str2bool($manage_package)
  } else {
    $manage_package_real = $manage_package
  }
  validate_bool($manage_package_real)

  if $manage_package_real == true {

    if $::osfamily == 'RedHat' {
      $default_package_name = 'collectd-dns'
    } else {
      # This will cause the catalog to fail if package_name is not specified
      $default_package_name = 'USE_DEFAULTS'
    }

    if $package_name == 'USE_DEFAULTS' {
      $package_name_real = $default_package_name
    } else {
      $package_name_real = $package_name
    }
    validate_string($package_name_real)

    if $package_name_real == 'USE_DEFAULTS' {
      fail("collectd::plugin::dns::package_name must be specified when using an unsupported OS. Supported osfamily is RedHat. Detected is <${::osfamily}>.")
    }

    package { 'collectd-dns':
      ensure => $ensure,
      name   => $package_name_real,
    }
  }

  collectd::plugin { 'dns':
    ensure   => $ensure,
    content  => template('collectd/plugin/dns.conf.erb'),
    interval => $interval,
  }
}
