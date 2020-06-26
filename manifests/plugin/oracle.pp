# Oracle plugin
# https://collectd.org/wiki/index.php/Plugin:Oracle
class collectd::plugin::oracle (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $manage_package           = false,
  Optional[Integer[1]] $interval    = undef,
) {
  include collectd

  $conf_dir = $collectd::plugin_conf_dir

  if $manage_package {
    package { 'collectd-oracle':
      ensure => $ensure,
    }
  }

  collectd::plugin { 'oracle':
    ensure   => $ensure,
    interval => $interval,
  }

  concat { "${conf_dir}/15-oracle.conf":
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
      target  => "${conf_dir}/15-oracle.conf",
  }

  concat::fragment {
    'collectd_plugin_oracle_conf_footer':
      order   => '99',
      content => '</Plugin>',
      target  => "${conf_dir}/15-oracle.conf",
  }
}
