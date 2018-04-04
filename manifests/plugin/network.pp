# https://collectd.org/wiki/index.php/Plugin:Network
class collectd::plugin::network (
  Enum['present', 'absent'] $ensure          = 'present',
  Optional[Pattern[/[0-9]+/]] $timetolive    = undef,
  Optional[Pattern[/[0-9]+/]] $maxpacketsize = undef,
  Optional[Boolean] $forward                 = undef,
  Optional[Integer[1]] $interval             = undef,
  Optional[Boolean] $reportstats             = undef,
  Hash $listeners                            = {},
  Hash $servers                              = {},
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
