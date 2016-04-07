# https://collectd.org/wiki/index.php/Plugin:TCPConns
class collectd::plugin::tcpconns (
  $localports      = undef,
  $remoteports     = undef,
  $listening       = undef,
  $interval        = undef,
  $allportssummary = undef,
  $ensure = undef
) {

  include ::collectd

  if $localports {
    validate_array($localports)
  }

  if $remoteports {
    validate_array($remoteports)
  }

  if $allportssummary {
    validate_bool($allportssummary)
  }

  collectd::plugin { 'tcpconns':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/tcpconns.conf.erb'),
    interval => $interval,
  }
}
