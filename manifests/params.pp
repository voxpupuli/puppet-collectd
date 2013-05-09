class collectd::params {

  case $::osfamily {
    'Debian': {
      $package           = 'collectd'
      $provider          = 'apt'
      $collectd_dir      = '/etc/collectd'
      $plugin_conf_dir   = "${collectd_dir}/conf.d"
      $service_name      = 'collectd'
      $config_file       = "${collectd_dir}/collectd.conf"
    }
    'Solaris': {
      $package           = 'CSWcollectd'
      $provider          = 'pkgutil'
      $collectd_dir      = '/etc/opt/csw'
      $plugin_conf_dir   = "${collectd_dir}/conf.d"
      $service_name      = 'collectd'
      $config_file       = "${collectd_dir}/collectd.conf"
    }
    'Redhat': {
      $package           = "collectd.${::architecture}"
      $provider          = 'yum'
      $collectd_dir      = '/etc/collectd.d'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = "/etc/collectd.conf"
    }
    default: {
      fail("${::osfamily} is not supported.")
    }
  }

}
