# https://collectd.org/wiki/index.php/Plugin:OpenVPN
class collectd::plugin::openvpn (
  $ensure                 = present,
  $statusfile             = '/etc/openvpn/openvpn-status.log',
  $improvednamingschema   = false,
  $collectcompression     = true,
  $collectindividualusers = true,
  $collectusercount       = false,
) {
  validate_absolute_path($statusfile)
  validate_bool(
    $improvednamingschema,
    $collectcompression,
    $collectindividualusers,
    $collectusercount,
  )

  collectd::plugin {'openvpn':
    ensure  => $ensure,
    content => template('collectd/plugin/openvpn.conf.erb'),
  }
}
