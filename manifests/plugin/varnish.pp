# https://collectd.org/wiki/index.php/Plugin:Varnish
class collectd::plugin::varnish (
  $ensure           = present,
  $instances        = {
      'localhost' => {
        'CollectCache' => 'true',
        'CollectBackend' => 'true',
        'CollectConnections' => 'true',
        'CollectSHM' => 'true',
        'CollectESI' => 'false',
        'CollectFetch' => 'true',
        'CollectHCB' => 'false',
        'CollectTotals' => 'true',
        'CollectWorkers' => 'true',
    }
  }
) {
  include collectd::params

  if versioncmp(collectd_version, 5.4) == -1 {
    fail('Only collectd v5.4 and varnish v3 are supported!')
  }

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_hash(
    $instances
  )

  if $collectd::params::varnish_pacakge {

    package { "${collectd::params::package}-${collectd::params::varnish_package}":
      ensure => installed
    }

  }

  file { 'varnish.conf':
    ensure    => $collectd::plugin::varnish::ensure,
    path      => "${conf_dir}/varnish.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/varnish.conf.erb'),
    notify    => Service['collectd'],
  }
}
