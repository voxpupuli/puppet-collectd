# https://collectd.org/wiki/index.php/Plugin:RRDtool
class collectd::plugin::rrdtool (
  $ensure                            = 'present',
  $manage_package                    = undef,
  Stdlib::Absolutepath $datadir      = '/var/lib/collectd/rrd',
  Boolean $createfilesasync          = false,
  $interval                          = undef,
  Integer $rrarows                   = 1200,
  Array[Integer] $rratimespan        = [3600, 86400, 604800, 2678400, 31622400],
  Float $xff                         = 0.1,
  Integer $cacheflush                = 900,
  Integer $cachetimeout              = 120,
  Integer $writespersecond           = 50
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-rrdtool':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'rrdtool':
    ensure   => $ensure,
    content  => template('collectd/plugin/rrdtool.conf.erb'),
    interval => $interval,
  }
}
