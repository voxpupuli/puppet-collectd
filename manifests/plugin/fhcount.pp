# https://collectd.org/wiki/index.php/Plugin:Fhcount
class collectd::plugin::fhcount (
  $ensure                   = 'present',
  Boolean $valuesabsolute   = true,
  Boolean $valuespercentage = false,
  $interval                 = undef,
) {
  include collectd

  collectd::plugin { 'fhcount':
    ensure   => $ensure,
    content  => template('collectd/plugin/fhcount.conf.erb'),
    interval => $interval,
  }
}
