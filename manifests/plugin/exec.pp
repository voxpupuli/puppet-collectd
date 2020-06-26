# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_exec
class collectd::plugin::exec (
  Hash $commands          = {},
  Hash $commands_defaults = {},
  $interval               = undef,
  $ensure                 = 'present',
  Boolean $globals        = false,
) {
  include collectd

  collectd::plugin { 'exec':
    ensure   => $ensure,
    globals  => $globals,
    interval => $interval,
  }

  # should be loaded after global plugin configuration
  $exec_conf = "${collectd::plugin_conf_dir}/exec-config.conf"

  concat { $exec_conf:
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }

  concat::fragment { 'collectd_plugin_exec_conf_header':
    order   => '00',
    content => '<Plugin exec>',
    target  => $exec_conf,
  }

  concat::fragment { 'collectd_plugin_exec_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => $exec_conf,
  }

  $commands.each |String $resource, Hash $attributes| {
    collectd::plugin::exec::cmd { $resource:
      * => $commands_defaults + $attributes,
    }
  }
}
