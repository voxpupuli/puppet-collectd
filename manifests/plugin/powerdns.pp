# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_powerdns
class collectd::plugin::powerdns (
  Enum['present', 'absent'] $ensure       = 'present',
  Integer $order                          = 10,
  Optional[Numeric] $interval             = undef,
  Optional[Hash[String, Hash]] $servers   = {},
  Optional[Hash[String, Hash]] $recursors = {},
  Optional[String] $local_socket          = undef,
) {
  include collectd

  $servers_defaults   = { 'ensure' => $ensure }
  $recursors_defaults = { 'ensure' => $ensure }

  collectd::plugin { 'powerdns':
    ensure   => $ensure,
    order    => $order,
    interval => $interval,
  }

  concat { "${collectd::plugin_conf_dir}/powerdns-config.conf":
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }
  concat::fragment { 'collectd_plugin_powerdns_conf_header':
    order   => '00',
    content => epp('collectd/plugin/powerdns-header.conf.epp'),
    target  => "${collectd::plugin_conf_dir}/powerdns-config.conf",
  }

  concat::fragment { 'collectd_plugin_powerdns_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::plugin_conf_dir}/powerdns-config.conf",
  }

  $servers.each |String $resource, Hash $attributes| {
    collectd::plugin::powerdns::server { $resource:
      * => $servers_defaults + $attributes,
    }
  }

  $recursors.each |String $resource, Hash $attributes| {
    collectd::plugin::powerdns::recursor { $resource:
      * => $recursors_defaults + $attributes,
    }
  }
}
