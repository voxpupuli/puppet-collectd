#
class collectd::plugin::chain (
  String $chainname                       = 'Main',
  Collectd::Filter::Target $defaulttarget = 'write',
  Enum['present', 'absent'] $ensure       = 'present',
  Array $rules                            = []
) {

  include collectd

  $conf_dir = $collectd::plugin_conf_dir

  file { "${conf_dir}/99-chain-${chainname}.conf":
    ensure  => $ensure,
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/plugin/chain.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
