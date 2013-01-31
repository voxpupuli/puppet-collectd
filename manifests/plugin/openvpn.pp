class collectd::plugin::openvpn (
  $statusfile             = '/etc/openvpn/openvpn-status.log',
  $improvednamingschema   = 'false',
  $collectcompression     = 'true',
  $collectindividualusers = 'true',
  $collectusercount       = 'false',
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'openvpn.conf':
    path      => "${conf_dir}/openvpn.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/openvpn.conf.erb'),
    notify    => Service['collectd'],
  }
}
