# https://collectd.org/wiki/index.php/Plugin:IPMI
class collectd::plugin::ipmi (
  $ensure                    = 'present',
  $ensure_package            = 'present',
  $ignore_selected           = false,
  $interval                  = undef,
  $manage_package            = undef,
  $notify_sensor_add         = false,
  $notify_sensor_remove      = true,
  $notify_sensor_not_present = false,
  $sensors                   = undef,
) {

  include ::collectd

  $manage_package_real = pick($manage_package, $::collectd::manage_package)
  $sensors_real        = pick($sensors, [])

  validate_array($sensors_real)
  validate_bool(
    $ignore_selected,
    $notify_sensor_add,
    $notify_sensor_not_present,
    $notify_sensor_remove,
  )

  if $::osfamily == 'Redhat' {
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
