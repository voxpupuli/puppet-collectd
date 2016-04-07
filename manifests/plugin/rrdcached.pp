# https://collectd.org/wiki/index.php/Rrdcached
class collectd::plugin::rrdcached (
  $ensure = undef
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
) {

  include ::collectd

  validate_array($rratimespan)
  validate_bool($createfiles, $createfilesasync)

  collectd::plugin { 'rrdcached':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/rrdcached.conf.erb'),
    interval => $interval,
  }
}
