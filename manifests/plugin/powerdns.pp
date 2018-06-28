# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_powerdns
class collectd::plugin::powerdns (
  Enum['present', 'absent'] $ensure       = 'present',
  Integer $order                          = 10,
  Optional[Numeric] $interval             = undef,
  Optional[Hash[String, Hash]] $servers   = undef,
  Optional[Hash[String, Hash]] $recursors = undef,
  Optional[String] $local_socket          = undef,
) {

  include collectd

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

  $defaults = { 'ensure' => $ensure }

  if $servers {
    create_resources(
      collectd::plugin::powerdns::server,
      $servers,
      $defaults,
    )
  }

  if $recursors {
    create_resources(
      collectd::plugin::powerdns::recursor,
      $recursors,
      $defaults
    )
  }
}
