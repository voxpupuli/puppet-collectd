# https://collectd.org/wiki/index.php/Plugin:Network
class collectd::plugin::network (
  $ensure                                    = 'present',
  Optional[Pattern[/[0-9]+/]] $timetolive    = undef,
  Optional[Pattern[/[0-9]+/]] $maxpacketsize = undef,
  $forward                                   = undef,
  $interval                                  = undef,
  $reportstats                               = undef,
  $listeners                                 = { },
  $servers                                   = { },
) {

  include ::collectd

  collectd::plugin { 'network':
    ensure   => $ensure,
    content  => template('collectd/plugin/network.conf.erb'),
    interval => $interval,
  }
  $defaults = {
    'ensure' => $ensure,
  }
  create_resources(collectd::plugin::network::listener, $listeners, $defaults)
  create_resources(collectd::plugin::network::server, $servers, $defaults)
}
