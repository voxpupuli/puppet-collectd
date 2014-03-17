# https://collectd.org/wiki/index.php/Graphite
class collectd::plugin::write_graphite (
  $ensure          = present,
  $graphitehost    = 'localhost',
  $graphiteport    = 2003,
  $storerates      = false,
  $graphiteprefix  = 'collectd.',
  $graphitepostfix = undef,
  $escapecharacter = '_',
  $alwaysappendds  = false,
  $protocol        = 'tcp',
) {
  validate_bool($storerates)

  collectd::plugin {'write_graphite':
    ensure  => $ensure,
    content => template('collectd/plugin/write_graphite.conf.erb'),
  }
}
