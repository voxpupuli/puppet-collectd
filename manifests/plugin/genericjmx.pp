# https://collectd.org/wiki/index.php/Plugin:GenericJMX
class collectd::plugin::genericjmx (
  $ensure         = 'present',
  $jvmarg         = [],
  $manage_package = undef,
) {
  include collectd
  include collectd::plugin::java

  $class_path  = "${collectd::java_dir}/collectd-api.jar:${collectd::java_dir}/generic-jmx.jar"
  $config_file = "${collectd::plugin_conf_dir}/15-genericjmx.conf"

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-generic-jmx':
        ensure => $ensure,
      }
    }
  }

  concat { $config_file:
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
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
