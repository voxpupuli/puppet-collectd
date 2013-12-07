# https://collectd.org/wiki/index.php/Plugin:OpenVPN
class collectd::plugin::openvpn (
  $statusfile             = '/etc/openvpn/openvpn-status.log',
  $improvednamingschema   = false,
  $collectcompression     = true,
  $collectindividualusers = true,
  $collectusercount       = false,
  $ensure                 = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_absolute_path($statusfile)
  validate_bool(
    $improvednamingschema,
    $collectcompression,
    $collectindividualusers,
    $collectusercount,
  )

  file { 'openvpn.conf':
    ensure    => $collectd::plugin::openvpn::ensure,
    path      => "${conf_dir}/openvpn.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/openvpn.conf.erb'),
    notify    => Service['collectd'],
  }
}
