# https://collectd.org/wiki/index.php/Plugin:TCPConns
class collectd::plugin::tcpconns (
  Optional[Array] $localports        = undef,
  Optional[Array] $remoteports       = undef,
  $listening                         = undef,
  $interval                          = undef,
  Optional[Boolean] $allportssummary = undef,
  $ensure                            = 'present'
) {

  include ::collectd

  collectd::plugin { 'tcpconns':
    ensure   => $ensure,
    content  => template('collectd/plugin/tcpconns.conf.erb'),
    interval => $interval,
  }
}
