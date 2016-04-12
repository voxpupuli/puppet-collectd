# https://collectd.org/wiki/index.php/Plugin:GenericJMX
class collectd::plugin::genericjmx (
  $ensure         = 'present',
  $jvmarg         = [],
  $manage_package = undef,
) {

  include ::collectd
  include ::collectd::plugin::java

  $class_path  = "${collectd::java_dir}/collectd-api.jar:${collectd::java_dir}/generic-jmx.jar"
  $config_file = "${collectd::plugin_conf_dir}/15-genericjmx.conf"

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-generic-jmx':
        ensure => $ensure,
      }
    }
  }

  concat { $config_file:
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::root_group,
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
