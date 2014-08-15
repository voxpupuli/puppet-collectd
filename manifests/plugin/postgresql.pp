# https://collectd.org/wiki/index.php/Plugin:PostgreSQL
class collectd::plugin::postgresql (
  $ensure    = present,
  $databases = { },
  $queries   = { },
  $writers   = { },
) {
  include collectd::params

  collectd::plugin {'postgresql':
    ensure => $ensure,
  }

  concat{"${collectd::params::plugin_conf_dir}/postgresql-config.conf":
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::params::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }
  concat::fragment{'collectd_plugin_postgresql_conf_header':
    order   => '00',
    content => '<Plugin postgresql>',
    target  => "${collectd::params::plugin_conf_dir}/postgresql-config.conf",
  }
  concat::fragment{'collectd_plugin_postgresql_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::params::plugin_conf_dir}/postgresql-config.conf",
  }

  $defaults = {
    'ensure' => $ensure
  }
  create_resources(collectd::plugin::postgresql::database, $databases, $defaults)
  create_resources(collectd::plugin::postgresql::query, $queries, $defaults)
  create_resources(collectd::plugin::postgresql::writer, $writers, $defaults)
}
