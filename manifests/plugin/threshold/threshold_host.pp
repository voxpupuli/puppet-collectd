define collectd::plugin::threshold::threshold_host (
  $threshold_hostname = $name,
  $threshold_plugin   = undef,
  $threshold_type     = undef,
  $threshold_instance = undef,
  $warningmin         = undef,
  $warningmax         = undef,
  $failuremin         = undef,
  $failuremax         = undef,
  $hits               = undef,
  $hysteresis         = undef,
  $invert             = false,
  $persist            = false,
  $persistok          = false,
  $percentage         = false,
  $interesting        = true,
  $type_instance      = undef,
  $datasource         = undef,
  $ensure             = 'present'
) {

  include ::collectd::plugin::threshold
  include ::collectd

  validate_bool($invert)
  validate_bool($persist)
  validate_bool($persistok)
  validate_bool($percentage)
  validate_bool($interesting)

  $conf_file = "${collectd::plugin_conf_dir}/threshold-host-${title}.conf"

  concat{ $conf_file:
    ensure         => $ensure,
    mode           => '0640',
    owner          => 'root',
    group          => $collectd::root_group,
    notify         => Service['collectd'],
    ensure_newline => true,
  }

  concat::fragment { "collectd_plugin_threshold_conf_header_${threshold_hostname}":
    order   => '00',
    content => '<Plugin "threshold">',
    target  => "${conf_file}",
  }

  concat::fragment{ "collectd_plugin_threshold_conf_threshold_${threshold_hostname}_header":
    order   => '10',
    content => "  <Host \"${threshold_hostname}\">\n",
    target  => "${conf_file}",
  }

  concat::fragment{ "collectd_plugin_threshold_conf_threshold_${threshold_hostname}_plugin_header":
    order   => '15',
    content => "  <Plugin \"${threshold_plugin}\">\n",
    target  => "${conf_file}",
  }

  concat::fragment { "collectd_plugin_threshold_conf_threshold_${threshold_hostname}_type":
    order   => 50,
    content => template('collectd/plugin/threshold/threshold_type.conf.erb'),
    target  => "${conf_file}",
  }

  concat::fragment{ "collectd_plugin_threshold_conf_threshold_${threshold_hostname}_plugin_footer":
    order   => '75',
    content => "  </Plugin>\n",
    target  => "${conf_file}",
  }

  concat::fragment{ "collectd_plugin_threshold_conf_threshold_${threshold_hostname}_footer":
    order   => '80',
    content => "  </Host>\n",
    target  => "${conf_file}",
  }

  concat::fragment { "collectd_plugin_threshold_conf_footer_${threshold_hostname}":
    order   => '99',
    content => '</Plugin>',
    target  => "${conf_file}",
  }
}
