class collectd::params {

  case $::osfamily {
    'Debian': {
      $package           = 'collectd'
      $provider          = 'apt'
      $collectd_dir      = '/etc/collectd'
      $plugin_conf_dir   = "${collectd_dir}/collectd.d"
      $service_name      = 'collectd'
      $config_file      = "${collectd_dir}/collectd.conf"
    }
    'Solaris': {
      $package           = 'CSWcollectd'
      $provider          = 'pkgutil'
      $collectd_dir      = '/etc/opt/csw'
      $plugin_conf_dir   = "${collectd_dir}/collectd.d"
      $service_name      = 'collectd'
      $config_file      = "${collectd_dir}/collectd.conf"
    }
    'Redhat': {
      fail('Not implemented yet.')
    }
    default: {
      fail("${::osfamily} is not supported.")
    }
  }

}
