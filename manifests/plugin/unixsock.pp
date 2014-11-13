# https://collectd.org/wiki/index.php/Plugin:UnixSock
class collectd::plugin::unixsock (
  $socketfile   = '/var/run/collectd-socket',
  $socketgroup  = 'collectd',
  $socketperms  = '0770',
  $deletesocket = false,
  $ensure       = present,
  $interval     = undef,
) {
  validate_absolute_path($socketfile)

  collectd::plugin {'unixsock':
    ensure   => $ensure,
    content  => template('collectd/plugin/unixsock.conf.erb'),
    interval => $interval,
  }
}
