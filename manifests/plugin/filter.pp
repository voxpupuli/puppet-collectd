# https://collectd.org/wiki/index.php/Chains
class collectd::plugin::filter (
  $ensure          = 'present',
  $precachechain   = 'PreChain',
  $postcachechain  = 'PostChain',
) {
  include ::collectd::params

  $plugin_matches = ['regex','timediff','value','empty_counter','hashed']
  $plugin_targets = ['notification','replace','set']
  $conf_file = "${collectd::params::plugin_conf_dir}/01-filter.conf"

  file { $conf_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => $collectd::params::root_group,
    mode    => '0644',
    content => "PreCacheChain \"${precachechain}\"\nPostCacheChain \"${postcachechain}\"\n\n",
    notify  => Service['collectd'],
  }

  unless $ensure == 'present' {
    #kick all filter specifc plugins
    ensure_resource('collectd::plugin', prefix($plugin_matches,'match_'), {'ensure' => 'absent', 'order' => '02'} )
    ensure_resource('collectd::plugin', prefix($plugin_targets,'target_'), {'ensure' => 'absent', 'order' => '02'} )
  }

}
