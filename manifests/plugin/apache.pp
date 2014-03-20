# https://collectd.org/wiki/index.php/Plugin:Apache
class collectd::plugin::apache (
  $ensure     = present,
  $instances  = { 'localhost' => { 'url' => 'http://localhost/mod_status?auto' } },
) {

  validate_hash($instances)

  collectd::plugin {'apache':
    ensure  => $ensure,
    content => template('collectd/plugin/apache.conf.erb'),
  }
}
