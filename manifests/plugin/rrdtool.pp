# https://collectd.org/wiki/index.php/Plugin:RRDtool
class collectd::plugin::rrdtool (
  $ensure                            = 'present',
  $manage_package                    = undef,
  Stdlib::Absolutepath $datadir      = '/var/lib/collectd/rrd',
  Boolean $createfilesasync          = false,
  $interval                          = undef,
  Optional[Integer] $rrarows         = 1200,
  Array[Integer] $rratimespan        = [3600, 86400, 604800, 2678400, 31622400],
  Optional[Float] $xff               = 0.1,
  Optional[Integer] $cacheflush      = 900,
  Optional[Integer] $cachetimeout    = 120,
  Optional[Integer] $writespersecond = 50
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
