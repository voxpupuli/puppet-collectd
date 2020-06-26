# https://collectd.org/wiki/index.php/Plugin:UnixSock
class collectd::plugin::unixsock (
  $deletesocket                    = false,
  $ensure                          = 'present',
  $interval                        = undef,
  Stdlib::Absolutepath $socketfile = '/var/run/collectd-unixsock',
  $socketgroup                     = 'collectd',
  $socketperms                     = '0770'
) {

  include collectd

  collectd::plugin { 'unixsock':
    ensure   => $ensure,
    content  => template('collectd/plugin/unixsock.conf.erb'),
    interval => $interval,
  }
}
