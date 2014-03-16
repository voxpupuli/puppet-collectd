# https://collectd.org/wiki/index.php/Plugin:TCPConns
class collectd::plugin::tcpconns (
  $localports  = undef,
  $remoteports = undef,
  $listening   = false,
  $ensure      = present
) {

  if ! $localports and ! $remoteports {
    fail('Either local or remote ports need to be specified')
  }

  if $localports {
    validate_array($localports)
  }

  if $remoteports {
    validate_array($remoteports)
  }

  validate_bool($listening)

  collectd::plugin {'tcpconns':
    ensure  => $ensure,
    content => template('collectd/plugin/tcpconns.conf.erb'),
  }
}
