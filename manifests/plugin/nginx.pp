# https://collectd.org/wiki/index.php/Plugin:nginx
class collectd::plugin::nginx (
  $url,
  $cacert           = undef,
  $ensure           = 'present',
  $interval         = undef,
  $manage_package   = undef,
  $password         = undef,
  $user             = undef,
  $verifyhost       = undef,
  $verifypeer       = undef
) {

  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-nginx':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'nginx':
    ensure   => $ensure,
    content  => template('collectd/plugin/nginx.conf.erb'),
    interval => $interval,
  }
}
