# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_turbostat
class collectd::plugin::turbostat (
  Enum['present', 'absent'] $ensure                      = 'present',
  Optional[Integer]         $core_c_states               = undef,
  Optional[Integer]         $package_c_states            = undef,
  Optional[Boolean]         $system_management_interrupt = undef,
  Optional[Boolean]         $digital_temperature_sensor  = undef,
  Optional[Integer]         $tcc_activation_temp         = undef,
  Optional[Integer]         $running_average_power_limit = undef,
) {
  include ::collectd

  collectd::plugin { 'turbostat':
    ensure  => $ensure,
    content => template('collectd/plugin/turbostat.conf.erb'),
  }
}
