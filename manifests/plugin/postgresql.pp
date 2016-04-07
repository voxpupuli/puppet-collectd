# https://collectd.org/wiki/index.php/Plugin:PostgreSQL
class collectd::plugin::postgresql (
  $ensure = undef
  $manage_package = undef,
  $databases      = { },
  $interval       = undef,
  $queries        = { },
  $writers        = { },
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  if $::osfamily == 'Redhat' {
    if $_manage_package {
      package { 'collectd-postgresql':
        ensure => $ensure_real,
      }
    }
  }

  collectd::plugin { 'postgresql':
    ensure   => $ensure_real,
    interval => $interval,
  }

  concat{ "${collectd::plugin_conf_dir}/postgresql-config.conf":
    ensure         => $ensure_real,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }
  concat::fragment{ 'collectd_plugin_postgresql_conf_header':
    order   => '00',
    content => '<Plugin postgresql>',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
  }
  concat::fragment{ 'collectd_plugin_postgresql_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
  }

  $defaults = {
    'ensure' => $ensure_real,
  }
  create_resources(collectd::plugin::postgresql::database, $databases, $defaults)
  create_resources(collectd::plugin::postgresql::query, $queries, $defaults)
  create_resources(collectd::plugin::postgresql::writer, $writers, $defaults)
}
