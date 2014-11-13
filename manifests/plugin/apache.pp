# https://collectd.org/wiki/index.php/Plugin:Apache
class collectd::plugin::apache (
  $ensure     = present,
  $instances  = { 'localhost' => { 'url' => 'http://localhost/mod_status?auto' } },
  $interval   = undef,
) {

  validate_hash($instances)

  if $::osfamily == 'RedHat' {
    package { 'collectd-apache':
      ensure => $ensure,
    }
  }

  collectd::plugin {'apache':
    ensure   => $ensure,
    content  => template('collectd/plugin/apache.conf.erb'),
    interval => $interval,
  }
}
