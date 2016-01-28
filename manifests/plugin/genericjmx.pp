# https://collectd.org/wiki/index.php/Plugin:GenericJMX
class collectd::plugin::genericjmx (
  $jvmarg = [],
) {
  include ::collectd
  include ::collectd::params
  include ::collectd::plugin::java
  $class_path = "${collectd::params::java_dir}/collectd-api.jar:${collectd::params::java_dir}/generic-jmx.jar"
  $config_file = "${collectd::params::plugin_conf_dir}/15-genericjmx.conf"

  concat { $config_file:
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::params::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }
  concat::fragment {
    'collectd_plugin_genericjmx_conf_header':
      order   => '00',
      content => template('collectd/plugin/genericjmx.conf.header.erb'),
      target  => $config_file;
    'collectd_plugin_genericjmx_conf_footer':
      order   => '99',
      content => "  </Plugin>\n</Plugin>\n",
      target  => $config_file;
  }

}
