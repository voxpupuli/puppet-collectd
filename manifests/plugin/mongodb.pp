# Class: collectd::plugin::mongodb
#
class collectd::plugin::mongodb (
  String $db_user,
  String $db_pass,
  Enum['absent','present'] $ensure          = 'present',
  Optional[Variant[String,Float]] $interval = undef,
  Stdlib::Compat::Ip_address $db_host       = '127.0.0.1',
  Optional[String] $db_port                 = undef,
  Optional[Array] $configured_dbs           = undef,
  $collectd_dir                             = '/usr/lib/collectd',
) {

  include ::collectd

  if $configured_dbs {
    assert_type(String, $db_port)
  }

  collectd::plugin { 'mongodb':
    ensure   => $ensure,
    content  => template('collectd/plugin/mongodb.conf.erb'),
    interval => $interval,
  }
}
