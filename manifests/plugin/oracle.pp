# Oracle plugin
# https://collectd.org/wiki/index.php/Plugin:Oracle
class collectd::plugin::oracle (
  $ensure           = 'present',
  $manage_package   = undef,
  $interval         = undef,
) {
  include ::collectd

  $config_file = "${collectd::plugin_conf_dir}/15-oracle.conf"

  if $manage_package {
    package { 'collectd-oracle':
      ensure => $ensure,
    }
  }

  collectd::plugin { 'oracle':
    ensure   => $ensure,
    interval => $interval,
  }

  concat { $config_file:
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }

  concat::fragment {
    'collectd_plugin_oracle_conf_header':
      order   => '00',
      content => '<Plugin oracle>',
      target  => $config_file;
    'collectd_plugin_oracle_conf_footer':
      order   => '99',
      content => '</Plugin>',
      target  => $config_file;
  }
}
