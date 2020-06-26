# https://collectd.org/wiki/index.php/Plugin:cgroups
class collectd::plugin::cgroups (
  Array $cgroups                    = [],
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $ignore_selected          = false,
  Optional[Integer[1]] $interval    = undef,
) {
  include collectd

  collectd::plugin { 'cgroups':
    ensure   => $ensure,
    content  => template('collectd/plugin/cgroups.conf.erb'),
    interval => $interval,
  }
}
