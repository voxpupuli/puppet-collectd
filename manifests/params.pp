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
      $varnish_package   = 'core'
      $manage_package    = true
    }
    'Solaris': {
      $package           = 'CSWcollectd'
      $provider          = 'pkgutil'
      $collectd_dir      = '/etc/opt/csw'
      $plugin_conf_dir   = "${collectd_dir}/conf.d"
      $service_name      = 'collectd'
      $config_file       = "${collectd_dir}/collectd.conf"
      $root_group        = 'root'
      $varnish_package    = undef
      $manage_package    = true
    }
    'Redhat': {
      $package           = 'collectd'
      $provider          = 'yum'
      $collectd_dir      = '/etc/collectd.d'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/etc/collectd.conf'
      $root_group        = 'root'
      $varnish_package    = 'varnish'
      $manage_package    = true
    }
    'Suse': {
      $package           = 'collectd'
      $provider          = 'zypper'
      $collectd_dir      = '/etc/collectd'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/etc/collectd.conf'
      $root_group        = 'root'
      $varnish_package    = undef
      $manage_package    = true
    }
    'FreeBSD': {
      $package           = 'collectd5'
      $provider          = undef
      $collectd_dir      = '/usr/local/etc/collectd'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/usr/local/etc/collectd.conf'
      $root_group        = 'wheel'
      $varnish_package    = undef
      $manage_package    = true
    }
    'Archlinux': {
      $package           = 'collectd'
      $provider          = undef
      $collectd_dir      = '/etc/collectd.d'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'collectd'
      $config_file       = '/etc/collectd.conf'
      $root_group        = 'wheel'
      $varnish_package    = undef
      $manage_package    = true
    }
    'Darwin': {
      $package           = 'collectd'
      $provider          = 'homebrew'
      $collectd_dir      = '/usr/local/etc/collectd.d'
      $plugin_conf_dir   = $collectd_dir
      $service_name      = 'homebrew.mxcl.collectd'
      $config_file       = '/usr/local/etc/collectd.conf'
      $root_group        = 'wheel'
      $varnish_package   = undef
      $manage_package    = false

    }
    default: {
      fail("${::osfamily} is not supported.")
    }
  }

}
