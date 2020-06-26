define collectd::plugin::powerdns::server (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[String[1]] $socket       = undef,
  Array[String[1]] $collect         = [],
) {
  include collectd::plugin::powerdns
  include collectd

  concat::fragment { "collectd_plugin_powerdns_conf_server_${name}":
    order   => '50',
    content => epp('collectd/plugin/powerdns/server.conf.epp', {
        'name'    => $name,
        'socket'  => $socket,
        'collect' => $collect,
    }),
    target  => "${collectd::plugin_conf_dir}/powerdns-config.conf",
  }
}
