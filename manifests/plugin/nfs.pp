# https://collectd.org/wiki/index.php/Plugin:NFS
class collectd::plugin::nfs (
  $ensure = present,
) {
  collectd::plugin {'nfs':
    ensure => $ensure
  }
}
