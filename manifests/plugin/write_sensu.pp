# https://collectd.org/wiki/index.php/Plugin:Write_Sensu
class collectd::plugin::write_sensu (
  $ensure           = 'present',
  $manage_package   = undef,
  Stdlib::Host $sensu_host = 'localhost',
  Stdlib::Port $sensu_port = 3030,
  Boolean $store_rates      = false,
  Boolean $always_append_ds = false,
  $metrics          = false,
  $metrics_handler  = 'example_metric_handler',
  $notifications    = false,
  $notifs_handler   = 'example_notification_handler',
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-write_sensu':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'write_sensu':
    ensure  => $ensure,
    content => template('collectd/plugin/write_sensu.conf.erb'),
  }
}
