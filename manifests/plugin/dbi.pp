# https://collectd.org/wiki/index.php/Plugin:DBI
class collectd::plugin::dbi (
  $ensure         = 'present',
  $databases      = {},
  $queries        = {},
  $packages       = undef,
  $interval       = undef,
  $manage_package = undef,
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  $_databases_defaults = {
    'ensure' => $ensure,
  }

  $_queries_defaults   = {
    'ensure' => $ensure,
  }

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-dbi':
        ensure => $ensure,
      }
    }
  }

  #manage additional packages such like db driver: libdbi-mysql
  if $packages {
    package { $packages:
      ensure => $ensure,
    }
  }

  collectd::plugin { 'dbi':
    ensure   => $ensure,
    interval => $interval,
  }

  concat { "${collectd::plugin_conf_dir}/dbi-config.conf":
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }

  concat::fragment { 'collectd_plugin_dbi_conf_header':
    order   => '00',
    content => '<Plugin dbi>',
    target  => "${collectd::plugin_conf_dir}/dbi-config.conf",
  }

  concat::fragment { 'collectd_plugin_dbi_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::plugin_conf_dir}/dbi-config.conf",
  }

  $databases.each |String $resource, Hash $attributes| {
    collectd::plugin::dbi::database { $resource:
      * => $_databases_defaults + $attributes,
    }
  }

  $queries.each |String $resource, Hash $attributes| {
    collectd::plugin::dbi::query { $resource:
      * => $_queries_defaults + $attributes,
    }
  }
}
