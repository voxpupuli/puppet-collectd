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
  include collectd

  $listeners_defaults = {
    'ensure' => $ensure,
  }

  $servers_defaults   = {
    'ensure' => $ensure,
  }

  collectd::plugin { 'network':
    ensure   => $ensure,
    content  => template('collectd/plugin/network.conf.erb'),
    interval => $interval,
  }

  $listeners.each |String $resource, Hash $attributes| {
    collectd::plugin::network::listener { $resource:
      * => $listeners_defaults + $attributes,
    }
  }

  $servers.each |String $resource, Hash $attributes| {
    collectd::plugin::network::server { $resource:
      * => $servers_defaults + $attributes,
    }
  }
}
