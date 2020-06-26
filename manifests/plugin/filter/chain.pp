# https://collectd.org/wiki/index.php/Chains
define collectd::plugin::filter::chain (
  Enum['present', 'absent'] $ensure          = 'present',
  Optional[Collectd::Filter::Target] $target = undef,
  Optional[Hash] $target_options             = undef,
) {
  include collectd
  include collectd::plugin::filter

  $conf_file = "${collectd::plugin_conf_dir}/filter-chain-${title}.conf"

  concat { $conf_file:
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }

  if $ensure == 'present' {
    concat::fragment { "${conf_file}_${title}_head":
      order   => '00',
      content => "<Chain \"${title}\">",
      target  => $conf_file,
    }

    concat::fragment { "${conf_file}_${title}_footer":
      order   => '99',
      content => '</Chain>',
      target  => $conf_file,
    }

    #add simple target if provided at the end
    if $target {
      collectd::plugin::filter::target { "z_chain-${title}-target":
        chain   => $title,
        plugin  => $target,
        rule    => undef,
        options => $target_options,
      }
    }
  }
}
