# https://collectd.org/wiki/index.php/Plugin:PostgreSQL
class collectd::plugin::postgresql (
  $ensure         = 'present',
  $manage_package = undef,
  $databases      = {},
  $interval       = undef,
  $queries        = {},
  $writers        = {},
) {
  include collectd

  $_manage_package    = pick($manage_package, $collectd::manage_package)
  $databases_defaults = { 'ensure' => $ensure }
  $queries_defaults   = { 'ensure' => $ensure }
  $writers_defaults   = { 'ensure' => $ensure }

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-postgresql':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'postgresql':
    ensure   => $ensure,
    interval => $interval,
  }

  concat { "${collectd::plugin_conf_dir}/postgresql-config.conf":
    ensure         => $ensure,
    mode           => $collectd::config_mode,
    owner          => $collectd::config_owner,
    group          => $collectd::config_group,
    notify         => Service[$collectd::service_name],
    ensure_newline => true,
  }

  concat::fragment { 'collectd_plugin_postgresql_conf_header':
    order   => '00',
    content => '<Plugin postgresql>',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
  }
  concat::fragment { 'collectd_plugin_postgresql_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
  }

  $databases.each |String $resource, Hash $attributes| {
    collectd::plugin::postgresql::database { $resource:
      * => $databases_defaults + $attributes,
    }
  }

  $queries.each |String $resource, Hash $attributes| {
    collectd::plugin::postgresql::query { $resource:
      * => $queries_defaults + $attributes,
    }
  }

  $writers.each |String $resource, Hash $attributes| {
    collectd::plugin::postgresql::writer { $resource:
      * => $writers_defaults + $attributes,
    }
  }
}
