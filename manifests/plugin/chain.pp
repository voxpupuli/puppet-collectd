#
class collectd::plugin::chain (
  $chainname     = 'Main',
  $ensure        = 'present',
  $defaulttarget = 'write',
  $rules         = []
) {
  include ::collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { "${conf_dir}/99-chain-${chainname}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::params::root_group,
    content => template('collectd/plugin/chain.conf.erb'),
    notify  => Service['collectd'],
  }
}
