# https://collectd.org/wiki/index.php/Plugin:Varnish
class collectd::plugin::varnish (
  $ensure         = 'present',
  $manage_package = undef,
  $instances      = {
    'localhost' => {
    },
  },
  $interval       = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_hash($instances)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-varnish':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'varnish':
    ensure   => $ensure,
    content  => template('collectd/plugin/varnish.conf.erb'),
    interval => $interval,
  }
}
