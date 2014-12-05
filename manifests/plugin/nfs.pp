# https://collectd.org/wiki/index.php/Plugin:NFS
class collectd::plugin::nfs (
  $ensure   = present,
  $interval = undef,
) {
  collectd::plugin {'nfs':
    ensure   => $ensure,
    interval => $interval,
  }
}
