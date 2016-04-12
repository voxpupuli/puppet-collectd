# collectd::plugin::aggregation
class collectd::plugin::aggregation (
  $ensure      = 'present',
  $interval    = undef,
  $aggregators = { },
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
