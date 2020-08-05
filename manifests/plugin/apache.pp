# https://collectd.org/wiki/index.php/Plugin:Apache
class collectd::plugin::apache (
  Enum['present', 'absent'] $ensure        = 'present',
  Boolean $manage_package                  = $collectd::manage_package,
  Hash $instances                          = { 'localhost' => { 'url' => 'http://localhost/mod_status?auto' } },
  Optional[Integer[1]] $interval           = undef,
  Optional[Array] $package_install_options = $collectd::package_install_options,
) {
  include collectd

  if $facts['os']['family'] == 'RedHat' {
    if $manage_package {
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
