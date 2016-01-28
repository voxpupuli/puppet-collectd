# https://collectd.org/wiki/index.php/Plugin:GenericJMX
define collectd::plugin::genericjmx::connection (
  $collect,
  $service_url,
  $host = $name,
  $user = undef,
  $password = undef,
  $instance_prefix = undef,
) {
  include ::collectd::plugin::genericjmx
  concat::fragment { "collectd_plugin_genericjmx_conf_${name}":
    order   => 20,
    content => template('collectd/plugin/genericjmx/connection.conf.erb'),
    target  => $collectd::plugin::genericjmx::config_file;
  }
}
