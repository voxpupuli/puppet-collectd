define collectd::plugin::threshold::threshold_type (
  $values             = [],
  $ensure         = 'present'
) {

  include ::collectd::plugin::threshold
  include ::collectd

  validate_array($values)

  $conf_file = "${collectd::plugin_conf_dir}/threshold-type-${title}.conf"

  concat{ $conf_file:
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }

  concat::fragment { "collectd_plugin_threshold_conf_header_${title}":
    order   => '00',
    content => '<Plugin "threshold">',
    target  => "${conf_file}",
  }

  concat::fragment { "collectd_plugin_threshold_conf_threshold_type_${title}":
    order   => 50,
    content => template('collectd/plugin/threshold/threshold_type.conf.erb'),
    target  => "${conf_file}",
  }

  concat::fragment { "collectd_plugin_threshold_conf_footer_${title}":
    order   => '99',
    content => '</Plugin>',
    target  => "${conf_file}",
  }
}
