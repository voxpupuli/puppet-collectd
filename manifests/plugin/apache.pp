# https://collectd.org/wiki/index.php/Plugin:Apache
class collectd::plugin::apache (
  $ensure                                  = 'present',
  $manage_package                          = undef,
  Hash $instances                          = { 'localhost' => { 'url' => 'http://localhost/mod_status?auto' } },
  $interval                                = undef,
  Optional[Array] $package_install_options = $collectd::package_install_options,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-apache':
        ensure          => $ensure,
        install_options => $package_install_options,
      }
    }
  }

  collectd::plugin { 'apache':
    ensure   => $ensure,
    content  => template('collectd/plugin/apache.conf.erb'),
    interval => $interval,
  }
}
