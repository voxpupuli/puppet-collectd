#
class collectd::plugin::aggregation (
  $ensure      = file,
  $interval    = undef,
  $aggregators = { },
) {

  include ::collectd

  $ensure_real = pick($ensure, 'file')

  collectd::plugin { 'aggregation':
    ensure   => $ensure_real,
    interval => $interval,
  }
  $defaults = {
    'ensure' => $ensure_real,
  }
  create_resources(collectd::plugin::aggregation::aggregator, $aggregators, $defaults)
}
