# Class: collectd::plugin::mongodb
#
class collectd::plugin::mongodb (
  String $db_pass,
  String $db_user,
  $collectd_dir                             = '/usr/lib/collectd',
  Optional[Array] $configured_dbs           = undef,
  Stdlib::Host $db_host                     = '127.0.0.1',
  Optional[Stdlib::Port] $db_port           = undef,
  Enum['absent','present'] $ensure          = 'present',
  Optional[Variant[String,Float]] $interval = undef
) {

  include collectd

  if $configured_dbs {
    assert_type(Stdlib::Port, $db_port)
  }

  collectd::plugin { 'mongodb':
    ensure   => $ensure,
    content  => template('collectd/plugin/mongodb.conf.erb'),
    interval => $interval,
  }
}
