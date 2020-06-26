# https://collectd.org/wiki/index.php/Plugin:TCPConns
class collectd::plugin::tcpconns (
  Optional[Boolean] $allportssummary = undef,
  $ensure                            = 'present',
  $interval                          = undef,
  $listening                         = undef,
  Optional[Array[Stdlib::Port]] $localports  = undef,
  Optional[Array[Stdlib::Port]] $remoteports = undef
) {

  include collectd

  collectd::plugin { 'tcpconns':
    ensure   => $ensure,
    content  => template('collectd/plugin/tcpconns.conf.erb'),
    interval => $interval,
  }
}
