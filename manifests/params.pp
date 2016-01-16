#
class collectd::params {

  $fqdnlookup              = true
  $collectd_hostname       = $::hostname
  $interval                = 10
  $include                 = []
  $internal_stats          = false
  $purge                   = undef
  $purge_config            = false
  $recurse                 = undef
  $threads                 = 5
  $timeout                 = 2
  $typesdb                 = []
  $write_queue_limit_high  = undef
  $write_queue_limit_low   = undef
  $package_ensure          = 'installed'
  $service_ensure          = 'running'
  $service_enable          = true
  $minimum_version         = undef
  $manage_package          = true
  $package_install_options = undef
  $plugin_conf_dir_mode    = '0750'

  case $::osfamily {
    'Debian': {
      $package_name     = 'collectd'
      $package_provider = 'apt'
      $collectd_dir     = '/etc/collectd'
      $plugin_conf_dir  = "${collectd_dir}/conf.d"
      $service_name     = 'collectd'
      $config_file      = "${collectd_dir}/collectd.conf"
      $root_group       = 'root'
      $java_dir         = '/usr/share/collectd/java'
      $python_dir       = '/usr/share/collectd/python'
    }
    'Solaris': {
      $package_name     = 'CSWcollectd'
      $package_provider = 'pkgutil'
      $collectd_dir     = '/etc/opt/csw/collectd.d'
      $plugin_conf_dir  = $collectd_dir
      $service_name     = 'cswcollectd'
      $config_file      = '/etc/opt/csw/collectd.conf'
      $root_group       = 'root'
      $java_dir         = undef
      $python_dir       = '/opt/csw/share/collectd/python'
    }
    'Redhat': {
      $package_name     = 'collectd'
      $package_provider = 'yum'
      $collectd_dir     = '/etc/collectd.d'
      $plugin_conf_dir  = $collectd_dir
      $service_name     = 'collectd'
      $config_file      = '/etc/collectd.conf'
      $root_group       = 'root'
      $java_dir         = '/usr/share/collectd/java'
      $python_dir       = '/usr/share/collectd/python'
    }
    'Suse': {
      $package_name     = 'collectd'
      $package_provider = 'zypper'
      $collectd_dir     = '/etc/collectd'
      $plugin_conf_dir  = $collectd_dir
      $service_name     = 'collectd'
      $config_file      = '/etc/collectd.conf'
      $root_group       = 'root'
      $java_dir         = undef
      $python_dir       = '/usr/share/collectd/python'
    }
    'FreeBSD': {
      $package_name     = 'collectd5'
      $package_provider = undef
      $collectd_dir     = '/usr/local/etc/collectd'
      $plugin_conf_dir  = $collectd_dir
      $service_name     = 'collectd'
      $config_file      = '/usr/local/etc/collectd.conf'
      $root_group       = 'wheel'
      $java_dir         = undef
      $python_dir       = '/usr/local/share/collectd/python'
    }
    'Archlinux': {
      $package_name     = 'collectd'
      $package_provider = undef
      $collectd_dir     = '/etc/collectd.d'
      $plugin_conf_dir  = $collectd_dir
      $service_name     = 'collectd'
      $config_file      = '/etc/collectd.conf'
      $root_group       = 'wheel'
      $java_dir         = undef
      $python_dir       = '/usr/share/collectd/python'
    }
    'Gentoo': {
      $package_name     = 'app-admin/collectd'
      $package_provider = 'portage'
      $collectd_dir     = '/etc/collectd.d'
      $plugin_conf_dir  = $collectd_dir
      $service_name     = 'collectd'
      $config_file      = '/etc/collectd.conf'
      $root_group       = 'collectd'
      $java_dir         = undef
      $python_dir       = '/usr/share/collectd/python'
    }

    default: {
      fail("${::osfamily} is not supported.")
    }
  }
}
