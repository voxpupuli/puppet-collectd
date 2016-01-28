# https://collectd.org/wiki/index.php/Chains
define collectd::plugin::filter::chain (
  $ensure = 'present',
  $target = undef,
  $target_options = undef,
) {
  include ::collectd::params
  include ::collectd::plugin::filter

  $conf_file = "${collectd::params::plugin_conf_dir}/filter-chain-${title}.conf"

  concat{ $conf_file:
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::params::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }

  if $ensure == 'present' {
      concat::fragment{ "${conf_file}_${title}_head":
        order   => '00',
        content => "<Chain \"${title}\">",
        target  => $conf_file,
      }

      concat::fragment{ "${conf_file}_${title}_footer":
        order   => '99',
        content => '</Chain>',
        target  => $conf_file,
      }

      #add simple target if provided at the end
      if $target {
        collectd::plugin::filter::target{ "z_chain-${title}-target":
          chain   => $title,
          plugin  => $target,
          rule    => undef,
          options => $target_options,
        }
      }
  }
}
