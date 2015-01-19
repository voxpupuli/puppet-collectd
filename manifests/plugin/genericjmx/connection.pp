# https://collectd.org/wiki/index.php/Plugin:GenericJMX
define collectd::plugin::genericjmx::connection (
  $host = $name,
  $service_url,
  $user = undef,
  $password = undef,
  $instance_prefix = undef,
  $collect,
) {
  include collectd::plugin::genericjmx
  concat::fragment { "collectd_plugin_genericjmx_conf_${name}":
    order   => 20,
    content => template('collectd/plugin/genericjmx/connection.conf.erb'),
    target  => $collectd::plugin::genericjmx::config_file;
  }
}
