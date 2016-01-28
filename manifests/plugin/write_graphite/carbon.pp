# a single graphite backend
define collectd::plugin::write_graphite::carbon (
  $ensure            = present,
  $graphitehost      = 'localhost',
  $graphiteport      = 2003,
  $storerates        = true,
  $graphiteprefix    = 'collectd.',
  $graphitepostfix   = undef,
  $interval          = undef,
  $escapecharacter   = '_',
  $alwaysappendds    = false,
  $protocol          = 'tcp',
  $separateinstances = false,
  $logsenderrors     = true,
){
  include ::collectd::params
  include ::collectd::plugin::write_graphite

  validate_bool($storerates)
  validate_bool($alwaysappendds)
  validate_bool($separateinstances)
  validate_bool($logsenderrors)

  concat::fragment{"collectd_plugin_write_graphite_conf_${title}_${protocol}_${graphiteport}":
    ensure  => $ensure,
    order   => '50', # somewhere between header and footer
    target  => $collectd::plugin::write_graphite::graphite_conf,
    content => template('collectd/plugin/write_graphite/carbon.conf.erb'),
  }
}
