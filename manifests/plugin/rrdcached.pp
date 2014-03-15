# https://collectd.org/wiki/index.php/Rrdcached
class collectd::plugin::rrdcached (
  $ensure           = present,
  $daemonaddress    = 'unix:/tmp/rrdcached.sock',
  $datadir          = '/var/lib/rrdcached/db/collectd',
  $createfiles      = true,
  $createfilesasync = false,
  $stepsize         = undef,
  $heartbeat        = undef,
  $rrarows          = undef,
  $rratimespan      = [],
  $xff              = undef,
) {
  validate_array($rratimespan)
  validate_bool($createfiles, $createfilesasync)

  collectd::plugin {'rrdcached':
    ensure  => $ensure,
    content => template('collectd/plugin/rrdcached.conf.erb'),
  }
}
