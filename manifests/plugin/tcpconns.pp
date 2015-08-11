# https://collectd.org/wiki/index.php/Plugin:TCPConns
class collectd::plugin::tcpconns (
  $localports      = undef,
  $remoteports     = undef,
  $listening       = undef,
  $interval        = undef,
  $allportssummary = undef,
  $ensure          = present
) {

  if $localports {
    validate_array($localports)
  }

  if $remoteports {
    validate_array($remoteports)
  }

  if $allportssummary {
    validate_bool($allportssummary)
  }

  collectd::plugin {'tcpconns':
    ensure   => $ensure,
    content  => template('collectd/plugin/tcpconns.conf.erb'),
    interval => $interval,
  }
}
