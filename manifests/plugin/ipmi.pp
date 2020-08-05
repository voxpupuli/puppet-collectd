# https://collectd.org/wiki/index.php/Plugin:IPMI
class collectd::plugin::ipmi (
  $ensure                            = 'present',
  $ensure_package                    = 'present',
  Boolean $ignore_selected           = false,
  $interval                          = undef,
  $manage_package                    = undef,
  Boolean $notify_sensor_add         = false,
  Boolean $notify_sensor_remove      = true,
  Boolean $notify_sensor_not_present = false,
  Array $sensors                     = [],
) {
  include collectd

  $manage_package_real = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $manage_package_real {
      package { 'collectd-ipmi':
        ensure => $ensure_package,
      }
    }
  }

  collectd::plugin { 'ipmi':
    ensure   => $ensure,
    content  => template('collectd/plugin/ipmi.conf.erb'),
    interval => $interval,
  }
}
