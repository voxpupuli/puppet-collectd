# https://collectd.org/wiki/index.php/Target:v5_upgrade
class collectd::plugin::target_v5upgrade (
  $ensure = 'present',
) {
  include collectd

  collectd::plugin { 'target_v5upgrade':
    ensure  => $ensure,
    content => template('collectd/plugin/target_v5upgrade.conf.erb'),
    order   => '06',
  }
}
