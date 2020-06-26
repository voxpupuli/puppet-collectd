# https://collectd.org/wiki/index.php/Plugin:GenericJMX
define collectd::plugin::genericjmx::mbean (
  String $object_name,
  Array $values,
  Optional[String] $instance_prefix = undef,
  Array $instance_from              = [],
) {
  include collectd
  include collectd::plugin::genericjmx

  concat::fragment { "collectd_plugin_genericjmx_conf_${name}":
    order   => '10',
    content => template('collectd/plugin/genericjmx/mbean.conf.erb'),
    target  => $collectd::plugin::genericjmx::config_file,
  }
}
