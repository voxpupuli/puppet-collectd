#
define collectd::plugin::nut::ups (
  $ensure          = 'present',
) {

  include ::collectd
  include ::collectd::plugin::nut

  $conf_dir = $::collectd::plugin_conf_dir

  validate_string($name)

  file { "${conf_dir}/nut-ups-${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $::collectd::root_group,
    content => template('collectd/plugin/nut/ups.conf.erb'),
    notify  => Service['collectd'],
  }
}
