define collectd::plugin::powerdns::recursor (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[String[1]] $socket       = undef,
  Array[String[1]] $collect         = [],
) {
  include collectd::plugin::powerdns
  include collectd

  concat::fragment { "collectd_plugin_powerdns_conf_recursor_${name}":
    order   => '51',
    content => epp('collectd/plugin/powerdns/recursor.conf.epp', {
        'name'    => $name,
        'socket'  => $socket,
        'collect' => $collect,
    }),
    target  => "${collectd::plugin_conf_dir}/powerdns-config.conf",
  }
}
