# https://collectd.org/wiki/index.php/Plugin:Entropy
class collectd::plugin::filecount (
  $ensure      = present,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

}
