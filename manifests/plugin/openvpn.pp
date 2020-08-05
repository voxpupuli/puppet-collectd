# https://collectd.org/wiki/index.php/Plugin:OpenVPN
class collectd::plugin::openvpn (
  $ensure                                                                = 'present',
  Variant[Array[Stdlib::Absolutepath], Stdlib::Absolutepath] $statusfile = '/etc/openvpn/openvpn-status.log',
  Boolean $improvednamingschema                                          = false,
  Boolean $collectcompression                                            = true,
  Boolean $collectindividualusers                                        = true,
  Boolean $collectusercount                                              = false,
  $interval                                                              = undef,
) {
  include collectd

  if $statusfile =~ String {
    $statusfiles = [$statusfile]
  } else {
    $statusfiles = $statusfile
  }

  collectd::plugin { 'openvpn':
    ensure   => $ensure,
    content  => template('collectd/plugin/openvpn.conf.erb'),
    interval => $interval,
  }
}
