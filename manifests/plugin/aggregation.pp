# collectd::plugin::aggregation
class collectd::plugin::aggregation (
  Hash $aggregators                 = {},
  Enum['present', 'absent'] $ensure = 'present',
  Optional[Integer[1]] $interval    = undef
) {

  include collectd

  collectd::plugin { 'aggregation':
    ensure   => $ensure,
    interval => $interval,
  }

  $defaults = {
    'ensure' => $ensure,
  }

  $aggregators.each |String $resource, Hash $attributes| {
    collectd::plugin::aggregation::aggregator { $resource:
      * => $defaults + $attributes,
    }
  }
}
