# https://collectd.org/wiki/index.php/Plugin:cgroups
class collectd::plugin::cgroups (
  $cgroups          = undef,
  $ensure           = 'present',
  $ignore_selected  = false,
  $interval         = undef,
) {

  include ::collectd

  $cgroups_real = pick($cgroups, [])

  validate_array($cgroups_real)
  validate_bool($ignore_selected)

  collectd::plugin { 'cgroups':
    ensure   => $ensure,
    content  => template('collectd/plugin/cgroups.conf.erb'),
    interval => $interval,
  }
}
