# https://collectd.org/wiki/index.php/Plugin:Varnish
class collectd::plugin::varnish (
  $ensure    = present,
  $instances = {
      'localhost' => {
      }
    },
  $interval = undef,
) {
  include collectd::params

  validate_hash($instances)

  if $::osfamily == 'Redhat' {
    package { 'collectd-varnish':
      ensure => $ensure,
    }
  }

  collectd::plugin {'varnish':
    ensure   => $ensure,
    content  => template('collectd/plugin/varnish.conf.erb'),
    interval => $interval,
  }
}
