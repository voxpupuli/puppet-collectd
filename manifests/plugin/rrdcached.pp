# https://collectd.org/wiki/index.php/Rrdcached
class collectd::plugin::rrdcached (
  $ensure            = 'present',
  $daemonaddress     = 'unix:/tmp/rrdcached.sock',
  $datadir           = '/var/lib/rrdcached/db/collectd',
  $createfiles       = true,
  $createfilesasync  = false,
  $stepsize          = undef,
  $heartbeat         = undef,
  $interval          = undef,
  $rrarows           = undef,
  $rratimespan       = [],
  $xff               = undef,
  $collectstatistics = undef,
  $manage_package    = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-rrdcached':
        ensure => $ensure,
      }
    }
  }

  validate_array($rratimespan)
  validate_bool($createfiles, $createfilesasync)

  collectd::plugin { 'rrdcached':
    ensure   => $ensure,
    content  => template('collectd/plugin/rrdcached.conf.erb'),
    interval => $interval,
  }
}
