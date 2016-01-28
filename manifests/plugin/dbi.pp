# https://collectd.org/wiki/index.php/Plugin:DBI
class collectd::plugin::dbi (
  $ensure    = present,
  $databases = { },
  $queries   = { },
  $packages  = undef,
  $interval  = undef,
) {
  include ::collectd::params

  if $::osfamily == 'Redhat' {
    package { 'collectd-dbi':
      ensure => $ensure,
    }
  }

  #manage additional packages such like db driver: libdbi-mysql
  if $packages {
    package { $packages:
      ensure => $ensure,
    }
  }

  collectd::plugin {'dbi':
    ensure   => $ensure,
    interval => $interval,
  }

  concat{"${collectd::params::plugin_conf_dir}/dbi-config.conf":
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::params::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }
  concat::fragment{'collectd_plugin_dbi_conf_header':
    order   => '00',
    content => '<Plugin dbi>',
    target  => "${collectd::params::plugin_conf_dir}/dbi-config.conf",
  }
  concat::fragment{'collectd_plugin_dbi_conf_footer':
    order   => '99',
    content => '</Plugin>',
    target  => "${collectd::params::plugin_conf_dir}/dbi-config.conf",
  }

  $defaults = {
    'ensure' => $ensure,
  }
  create_resources(collectd::plugin::dbi::database, $databases, $defaults)
  create_resources(collectd::plugin::dbi::query, $queries, $defaults)
}
