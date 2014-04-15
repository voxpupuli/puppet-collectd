# https://collectd.org/wiki/index.php/Plugin:Varnish
class collectd::plugin::varnish (
  $ensure    = present,
  $instances = {
      'localhost' => {
        'CollectCache'       => true,
        'CollectBackend'     => true,
        'CollectConnections' => true,
        'CollectSHM'         => true,
        'CollectESI'         => false,
        'CollectFetch'       => true,
        'CollectHCB'         => false,
        'CollectTotals'      => true,
        'CollectWorkers'     => true,
      }
    }
) {
  include collectd::params

  validate_hash($instances)

  if $::osfamily == 'Redhat' {
    package { 'collectd-varnish':
      ensure => installed
    }
  }

  collectd::plugin {'varnish':
    ensure  => $ensure,
    content => template('collectd/plugin/varnish.conf.erb'),
  }
}
