# https://collectd.org/wiki/index.php/Graphite
class collectd::plugin::write_graphite (
  $ensure            = present,
  $graphitehost      = 'localhost',
  $graphiteport      = 2003,
  $storerates        = true,
  $graphiteprefix    = 'collectd.',
  $graphitepostfix   = undef,
  $escapecharacter   = '_',
  $alwaysappendds    = false,
  $protocol          = 'tcp',
  $separateinstances = false,
) {
  validate_bool($storerates)
  validate_bool($separateinstances)

  collectd::plugin {'write_graphite':
    ensure  => $ensure,
    content => template('collectd/plugin/write_graphite.conf.erb'),
  }
}
