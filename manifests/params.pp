#
class collectd::params {

  case $::osfamily {
    'Debian': {
      $package           = 'collectd'
      $provider          = 'apt'
      $collectd_dir      = '/etc/collectd'
      $plugin_conf_dir   = "${collectd_dir}/conf.d"
      $service_name      = 'collectd'
      $config_file       = "${collectd_dir}/collectd.conf"
      $root_group        = 'root'
      $java_dir          = '/usr/share/collectd/java'
    }
    'Solaris': {
      $package           = 'CSWcollectd'
      $provider          = 'pkgutil'
      $collectd_dir      = '/etc/opt/csw'
      $plugin_conf_dir   = "${collectd_dir}/conf.d"
      $service_name      = 'collectd'
      $config_file       = "${collectd_dir}/collectd.conf"
      $root_group        = 'root'
      # FIXME: $java_dir
    }
    'Redhat': {
      $package           = 'collectd'
      $provider          = 'yum'
      $collectd_dir      = '/etc/collectd.d'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/etc/collectd.conf'
      $root_group        = 'root'
      $java_dir          = '/usr/share/collectd/java'
    }
    'Suse': {
      $package           = 'collectd'
      $provider          = 'zypper'
      $collectd_dir      = '/etc/collectd'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/etc/collectd.conf'
      $root_group        = 'root'
      # FIXME: $java_dir
    }
    'FreeBSD': {
      $package           = 'collectd5'
      $provider          = undef
      $collectd_dir      = '/usr/local/etc/collectd'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/usr/local/etc/collectd.conf'
      $root_group        = 'wheel'
      # FIXME: $java_dir
    }
    'Archlinux': {
      $package           = 'collectd'
      $provider          = undef
      $collectd_dir      = '/etc/collectd.d'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/etc/collectd.conf'
      $root_group        = 'wheel'
      # FIXME: $java_dir
    }
    'Gentoo': {
      $package           = 'app-admin/collectd'
      $provider          = 'portage'
      $collectd_dir      = '/etc/collectd.d'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/etc/collectd.conf'
      $root_group        = 'collectd'
      # FIXME: $java_dir
    }

    default: {
      fail("${::osfamily} is not supported.")
    }
  }
}
