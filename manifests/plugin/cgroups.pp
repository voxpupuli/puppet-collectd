# https://collectd.org/wiki/index.php/Plugin:cgroups
class collectd::plugin::cgroups (
  Optional[Array] $cgroups = undef,
  $ensure                  = 'present',
  Boolean $ignore_selected = false,
  $interval                = undef,
) {

  include ::collectd

  $cgroups_real = pick($cgroups, [])

  collectd::plugin { 'cgroups':
    ensure   => $ensure,
    content  => template('collectd/plugin/cgroups.conf.erb'),
    interval => $interval,
  }
}
