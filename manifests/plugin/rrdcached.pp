# https://collectd.org/wiki/index.php/Rrdcached
class collectd::plugin::rrdcached (
  $ensure                   = 'present',
  $daemonaddress            = 'unix:/tmp/rrdcached.sock',
  $datadir                  = '/var/lib/rrdcached/db/collectd',
  Boolean $createfiles      = true,
  Boolean $createfilesasync = false,
  $stepsize                 = undef,
  $heartbeat                = undef,
  $interval                 = undef,
  $rrarows                  = undef,
  Array $rratimespan        = [],
  $xff                      = undef,
  $collectstatistics        = undef,
  $manage_package           = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-rrdcached':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'rrdcached':
    ensure   => $ensure,
    content  => template('collectd/plugin/rrdcached.conf.erb'),
    interval => $interval,
  }
}
