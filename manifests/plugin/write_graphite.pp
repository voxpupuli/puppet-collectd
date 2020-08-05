# https://collectd.org/wiki/index.php/Graphite
class collectd::plugin::write_graphite (
  Hash $carbons      = {},
  $carbon_defaults   = {},
  $ensure            = 'present',
  $globals           = false,
) {
  include collectd

  collectd::plugin { 'write_graphite':
    ensure  => $ensure,
    globals => $globals,
  }

  # should be loaded after global plugin configuration
  $graphite_conf = "${collectd::plugin_conf_dir}/write_graphite-config.conf"

  case $ensure {
    'present': {
      concat { $graphite_conf:
        mode           => $collectd::config_mode,
        owner          => $collectd::config_owner,
        group          => $collectd::config_group,
        notify         => Service[$collectd::service_name],
        ensure_newline => true,
      }

      concat::fragment { 'collectd_plugin_write_graphite_conf_header':
        order   => '00',
        content => '<Plugin write_graphite>',
        target  => $graphite_conf,
      }

      concat::fragment { 'collectd_plugin_write_graphite_conf_footer':
        order   => '99',
        content => '</Plugin>',
        target  => $graphite_conf,
      }

      $carbons.each |String $resource, Hash $attributes| {
        collectd::plugin::write_graphite::carbon { $resource:
          * => $carbon_defaults + $attributes,
        }
      }
    }
    'absent': {
      file { $graphite_conf:
        ensure => absent,
      }
    }
    default: { fail('ensure must be \'absent\' or \'present\'') }
  }
}
