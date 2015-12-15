# https://collectd.org/wiki/index.php/Plugin:Write_Riemann
class collectd::plugin::write_sensu (
  $ensure           = present,
  $manage_package   = $collectd::manage_package,
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
  validate_bool($store_rates)
  validate_bool($always_append_ds)

  if $::osfamily == 'Redhat' {
    if $manage_package {
      package { 'collectd-write_sensu':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin {'write_sensu':
    ensure   => $ensure,
    content  => template('collectd/plugin/write_sensu.conf.erb'),
    interval => $interval,
  }
}
