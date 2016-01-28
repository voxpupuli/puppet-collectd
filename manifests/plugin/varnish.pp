# https://collectd.org/wiki/index.php/Plugin:Varnish
class collectd::plugin::varnish (
  $ensure         = present,
  $manage_package = $collectd::manage_package,
  $instances      = {
    'localhost' => {
    },
  },
  $interval       = undef,
) {
  include ::collectd::params

  validate_hash($instances)

  if $::osfamily == 'Redhat' {
    if $manage_package {
      package { 'collectd-varnish':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin {'varnish':
    ensure   => $ensure,
    content  => template('collectd/plugin/varnish.conf.erb'),
    interval => $interval,
  }
}
