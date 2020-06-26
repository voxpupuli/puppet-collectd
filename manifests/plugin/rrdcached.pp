# https://collectd.org/wiki/index.php/Rrdcached
class collectd::plugin::rrdcached (
  $collectstatistics        = undef,
  Boolean $createfiles      = true,
  Boolean $createfilesasync = false,
  $daemonaddress            = 'unix:/tmp/rrdcached.sock',
  $datadir                  = '/var/lib/rrdcached/db/collectd',
  $ensure                   = 'present',
  $heartbeat                = undef,
  $interval                 = undef,
  $manage_package           = undef,
  $rrarows                  = undef,
  Array $rratimespan        = [],
  $stepsize                 = undef,
  $xff                      = undef
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
