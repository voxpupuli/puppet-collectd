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
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_array($rratimespan)
  validate_bool($createfiles, $createfilesasync)

  file { 'rrdcached.conf':
    ensure    => $collectd::plugin::interface::ensure,
    path      => "${conf_dir}/rrdcached.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/rrdcached.conf.erb'),
    notify    => Service['collectd']
  }
}
