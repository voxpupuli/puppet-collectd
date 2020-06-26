# https://collectd.org/wiki/index.php/Chains
class collectd::plugin::filter (
  $ensure          = 'present',
  $precachechain   = 'PreChain',
  $postcachechain  = 'PostChain',
) {
  include collectd

  $plugin_matches = ['regex','timediff','value','empty_counter','hashed']
  $plugin_targets = ['notification','replace','set','scale']
  $conf_file = "${collectd::plugin_conf_dir}/01-filter.conf"

  file { $conf_file:
    ensure  => $ensure,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => "PreCacheChain \"${precachechain}\"\nPostCacheChain \"${postcachechain}\"\n\n",
    notify  => Service[$collectd::service_name],
  }

  unless $ensure == 'present' {
    #kick all filter specifc plugins
    ensure_resource('collectd::plugin', prefix($plugin_matches,'match_'), { 'ensure' => 'absent', 'order' => '02' })
    ensure_resource('collectd::plugin', prefix($plugin_targets,'target_'), { 'ensure' => 'absent', 'order' => '02' })
  }
}
