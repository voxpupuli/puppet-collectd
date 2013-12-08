# https://collectd.org/wiki/index.php/Plugin:TCPConns
class collectd::plugin::tcpconns (
  $localports  = undef,
  $remoteports = undef,
  $listening   = false,
  $ensure      = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  if ! $localports and ! $remoteports {
    fail('Either local or remote ports need to be specified')
  }

  if $localports {
    validate_array($localports)
  }

  if $remoteports {
    validate_array($remoteports)
  }

  validate_bool($listening)

  file { 'tcpconns.conf':
    ensure    => $ensure,
    path      => "${conf_dir}/tcpconns.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/tcpconns.conf.erb'),
    notify    => Service['collectd']
  }
}
