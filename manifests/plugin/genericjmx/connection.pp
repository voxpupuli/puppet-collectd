# https://collectd.org/wiki/index.php/Plugin:GenericJMX
define collectd::plugin::genericjmx::connection (
  Array $collect,
  String $service_url,
  Optional[String] $host            = undef,
  Optional[String] $user            = undef,
  Optional[String] $password        = undef,
  Optional[String] $instance_prefix = undef,
) {
  include collectd
  include collectd::plugin::genericjmx

  concat::fragment { "collectd_plugin_genericjmx_conf_${name}":
    order   => 20,
    content => template('collectd/plugin/genericjmx/connection.conf.erb'),
    target  => $collectd::plugin::genericjmx::config_file,
  }
}
