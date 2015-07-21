# https://collectd.org/wiki/index.php/Plugin:OpenVPN
class collectd::plugin::openvpn (
  $ensure                 = present,
  $statusfile             = '/etc/openvpn/openvpn-status.log',
  $improvednamingschema   = false,
  $collectcompression     = true,
  $collectindividualusers = true,
  $collectusercount       = false,
  $interval               = undef,
) {
  if is_string($statusfile) {
    validate_absolute_path($statusfile)
    $statusfiles = [ $statusfile ]
  } elsif is_array($statusfile) {
    $statusfiles = $statusfile
  } else {
    fail("statusfile must be either array or string: ${statusfile}")
  }

  validate_bool(
    $improvednamingschema,
    $collectcompression,
    $collectindividualusers,
    $collectusercount,
  )

  collectd::plugin {'openvpn':
    ensure   => $ensure,
    content  => template('collectd/plugin/openvpn.conf.erb'),
    interval => $interval,
  }
}
