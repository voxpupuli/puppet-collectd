# https://collectd.org/wiki/index.php/Plugin:TCPConns
class collectd::plugin::tcpconns (
  $localports  = undef,
  $remoteports = undef,
  $listening   = undef,
  $ensure      = present
) {

  if $localports {
    validate_array($localports)
  }

  if $remoteports {
    validate_array($remoteports)
  }

  collectd::plugin {'tcpconns':
    ensure  => $ensure,
    content => template('collectd/plugin/tcpconns.conf.erb'),
  }
}
