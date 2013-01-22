class collectd::plugin::openvpn {
  include collectd::params

  $conf_dir          = $collectd::params::plugin_conf_dir
  $main_configs_file = $collectd::params::main_configs_file

  file_line { 'include_openvpn_conf':
    line    => "Include \"${conf_dir}/openvpn.conf\"",
    path    => $main_configs_file,
    require => Package['collectd'],
  }

  file { 'openvpn.conf':
    path      => "${conf_dir}/openvpn.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/openvpn.conf.erb'),
    subscribe => Service['collectd'],
  }
}
