# https://collectd.org/wiki/index.php/Plugin:SMART
class collectd::plugin::smart (
  Array $disks            = [],
  $ensure                 = 'present',
  Boolean $ignoreselected = false,
  $interval               = undef,
  $manage_package         = undef,
  $package_name           = 'collectd-smart',
) {
  include collectd

  if $facts['os']['family'] == 'RedHat' {
    if $manage_package != undef {
      $_manage_package = $manage_package
    } else {
      if versioncmp($collectd::collectd_version_real, '5.5') >= 0 {
        $_manage_package = true
      } else {
        $_manage_package = false
      }
    }

    if $_manage_package {
      package { 'collectd-smart':
        ensure => $ensure,
        name   => $package_name,
      }
    }
  }

  collectd::plugin { 'smart':
    ensure   => $ensure,
    content  => template('collectd/plugin/smart.conf.erb'),
    interval => $interval,
  }
}
