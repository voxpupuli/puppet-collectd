# https://collectd.org/wiki/index.php/Plugin:NFS
class collectd::plugin::nfs (
  $ensure = undef
  $interval = undef,
) {

  include ::collectd

  collectd::plugin { 'nfs':
    ensure   => $ensure_real,
    interval => $interval,
  }
}
