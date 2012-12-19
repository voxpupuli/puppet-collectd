class collectd::params {

  case $::osfamily {
    'Debian': {
      $package           = 'collectd'
      $provider          = 'apt'
      $collectd_dir      = '/etc/collectd'
      $plugin_conf_dir   = "${collectd_dir}/collectd.d"
      $service_name      = 'collectd'
      $main_configs_file = "${collectd_dir}/collectd.conf"
    }
    'Solaris': {
      fail('Not implemented yet.')
    }
    'Redhat': {
      fail('Not implemented yet.')
    }
    default: {
      fail("${::osfamily} is not supported.")
    }
  }

  # TODO: probably have a $write_graphite_host and $write_graphite_port for write_graphite
  # TODO: have a $ntpd_host and $ntpd_port for ntpd plugin since this is public
}
