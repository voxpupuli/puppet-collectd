#
class collectd::plugin::chain (
  $chainname     = 'Main',
  $ensure        = 'present',
  $defaulttarget = 'write',
  $rules         = []
) {

  include ::collectd

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
