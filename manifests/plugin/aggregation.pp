# collectd::plugin::aggregation
class collectd::plugin::aggregation (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[Integer[1]] $interval    = undef,
  Hash $aggregators                 = {},
) {

  include ::collectd

  collectd::plugin { 'aggregation':
    ensure   => $ensure,
    interval => $interval,
  }

  $defaults = {
    'ensure' => $ensure,
  }

  create_resources(collectd::plugin::aggregation::aggregator, $aggregators, $defaults)
}
