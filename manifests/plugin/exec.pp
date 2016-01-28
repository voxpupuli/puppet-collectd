# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_exec
class collectd::plugin::exec (
  $commands          = {},
  $interval          = undef,
  $ensure            = present,
  $globals           = false,
) {
  include ::collectd::params

  validate_hash($commands)
  validate_bool($globals)

  collectd::plugin {'exec':
    ensure   => $ensure,
    globals  => $globals,
    interval => $interval,
  }

  # should be loaded after global plugin configuration
  $exec_conf = "${collectd::params::plugin_conf_dir}/exec-config.conf"

  concat{ $exec_conf:
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::params::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }

  concat::fragment{'collectd_plugin_exec_conf_header':
    order   => '00',
    content => '<Plugin exec>',
    target  => $exec_conf,
  }

  concat::fragment{'collectd_plugin_exec_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => $exec_conf,
  }

  create_resources(collectd::plugin::exec::cmd, $commands)
}