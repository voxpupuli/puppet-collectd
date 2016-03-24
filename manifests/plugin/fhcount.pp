# https://collectd.org/wiki/index.php/Plugin:Fhcount
class collectd::plugin::fhcount (
  $ensure           = 'present',
  $valuesabsolute   = true,
  $valuespercentage = false,
  $interval         = undef,
) {

  include ::collectd

  validate_bool(
    $valuesabsolute,
    $valuespercentage,
  )

  collectd::plugin { 'fhcount':
    ensure   => $ensure,
    content  => template('collectd/plugin/fhcount.conf.erb'),
    interval => $interval,
  }
}
