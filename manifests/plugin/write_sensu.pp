# https://collectd.org/wiki/index.php/Plugin:Write_Sensu
class collectd::plugin::write_sensu (
  $ensure = undef
  $manage_package   = undef,
  $sensu_host       = 'localhost',
  $sensu_port       = 3030,
  $store_rates      = false,
  $always_append_ds = false,
  $interval         = undef,
  $metrics          = false,
  $metrics_handler  = 'example_metric_handler',
  $notifications    = false,
  $notifs_handler   = 'example_notification_handler',
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_bool($store_rates)
  validate_bool($always_append_ds)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-write_sensu':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'write_sensu':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/write_sensu.conf.erb'),
    interval => $interval,
  }
}
