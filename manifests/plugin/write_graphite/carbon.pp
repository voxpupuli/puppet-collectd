# a single graphite backend
define collectd::plugin::write_graphite::carbon (
  $ensure                    = 'present',
  Stdlib::Host $graphitehost = 'localhost',
  Stdlib::Port $graphiteport = 2003,
  Boolean $storerates        = true,
  $graphiteprefix            = 'collectd.',
  $graphitepostfix           = undef,
  $interval                  = undef,
  $escapecharacter           = '_',
  Boolean $alwaysappendds    = false,
  $protocol                  = 'tcp',
  Boolean $separateinstances = false,
  Boolean $logsenderrors     = true,
  Integer $reconnectinterval = 0,
) {
  include collectd
  include collectd::plugin::write_graphite

  concat::fragment { "collectd_plugin_write_graphite_conf_${title}_${protocol}_${graphiteport}":
    order   => '50', # somewhere between header and footer
    target  => $collectd::plugin::write_graphite::graphite_conf,
    content => template('collectd/plugin/write_graphite/carbon.conf.erb'),
  }
}
