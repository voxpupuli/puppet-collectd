#
define collectd::plugin::nut::ups (
  $ensure          = 'present',
) {
  include collectd
  include collectd::plugin::nut

  $conf_dir = $collectd::plugin_conf_dir

  file { "${conf_dir}/nut-ups-${name}.conf":
    ensure  => $ensure,
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/plugin/nut/ups.conf.erb'),
    notify  => Service['collectd'],
  }
}
