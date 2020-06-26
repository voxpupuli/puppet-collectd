# https://collectd.org/wiki/index.php/Plugin:OpenVPN
class collectd::plugin::openvpn (
  Boolean $collectcompression                                            = true,
  Boolean $collectindividualusers                                        = true,
  Boolean $collectusercount                                              = false,
  $ensure                                                                = 'present',
  Boolean $improvednamingschema                                          = false,
  $interval                                                              = undef,
  Variant[Array[Stdlib::Absolutepath], Stdlib::Absolutepath] $statusfile = '/etc/openvpn/openvpn-status.log'
) {

  include collectd

  if $statusfile =~ String {
    $statusfiles = [ $statusfile ]
  } else {
    $statusfiles = $statusfile
  }

  collectd::plugin { 'openvpn':
    ensure   => $ensure,
    content  => template('collectd/plugin/openvpn.conf.erb'),
    interval => $interval,
  }
}
