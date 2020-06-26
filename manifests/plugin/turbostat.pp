# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_turbostat
class collectd::plugin::turbostat (
  Optional[Integer]         $core_c_states               = undef,
  Optional[Boolean]         $digital_temperature_sensor  = undef,
  Enum['present', 'absent'] $ensure                      = 'present',
  Optional[Boolean]         $logical_core_names          = undef,
  Optional[Integer]         $package_c_states            = undef,
  Optional[Integer]         $running_average_power_limit = undef,
  Optional[Boolean]         $system_management_interrupt = undef,
  Optional[Integer]         $tcc_activation_temp         = undef
) {
  include collectd

  collectd::plugin { 'turbostat':
    ensure  => $ensure,
    content => epp('collectd/plugin/turbostat.conf.epp'),
  }
}
