#
class collectd::params {
  $autoloadplugin            = false
  $fqdnlookup                = true
  $collectd_hostname         = $facts['networking']['hostname']
  $conf_content              = undef
  $config_mode               = '0640'
  $config_owner              = 'root'
  $interval                  = 10
  $include                   = []
  $internal_stats            = false
  $purge                     = false
  $purge_config              = false
  $recurse                   = false
  $read_threads              = 5
  $write_threads             = 5
  $timeout                   = 2
  $typesdb                   = ['/usr/share/collectd/types.db']
  $write_queue_limit_high    = undef
  $write_queue_limit_low     = undef
  $package_ensure            = 'present'
  $service_ensure            = 'running'
  $service_enable            = true
  $minimum_version           = '4.8'
  $manage_package            = true
  $manage_service            = true
  $package_install_options   = undef
  $plugin_conf_dir_mode      = '0750'
  $ci_package_repo           = undef
  $package_keyserver         = 'keyserver.ubuntu.com'
  $utils                     = false

  case $facts['kernel'] {
    'OpenBSD': { $has_wordexp = false }
    default:   { $has_wordexp = true }
  }

  case $facts['os']['family'] {
    'Debian': {
      $package_name       = ['collectd', 'collectd-core']
      $package_provider   = 'apt'
      $collectd_dir       = '/etc/collectd'
      $plugin_conf_dir    = "${collectd_dir}/conf.d"
      $service_name       = 'collectd'
      $config_file        = "${collectd_dir}/collectd.conf"
      $config_group       = 'root'
      $java_dir           = '/usr/share/collectd/java'
      $default_python_dir = '/usr/local/lib/python2.7/dist-packages'
      $manage_repo        = $facts['os']['release']['full'] != '18.04'
      $package_configs    = {}
    }
    'Solaris': {
      $package_name       = 'CSWcollectd'
      $package_provider   = 'pkgutil'
      $collectd_dir       = '/etc/opt/csw/collectd.d'
      $plugin_conf_dir    = $collectd_dir
      $service_name       = 'cswcollectd'
      $config_file        = '/etc/opt/csw/collectd.conf'
      $config_group       = 'root'
      $java_dir           = undef
      $default_python_dir = '/opt/csw/share/collectd/python'
      $manage_repo        = false
      $package_configs    = {}
    }
    'RedHat': {
      $package_name       = 'collectd'
      $package_provider   = 'yum'
      $collectd_dir       = '/etc/collectd.d'
      $plugin_conf_dir    = $collectd_dir
      $service_name       = 'collectd'
      $config_file        = '/etc/collectd.conf'
      $config_group       = 'root'
      $java_dir           = '/usr/share/collectd/java'
      $default_python_dir = $facts['os']['release']['major'] ? {
        '7'     => '/usr/lib/python2.7/site-packages',
        default => '/usr/lib/python3.6/site-packages',
      }
      $manage_repo        = true
      $package_configs    = {
        ovs_events => 'ovs-events.conf',
        ovs_stats => 'ovs-stats.conf',
        processes => 'processes-config.conf',
        virt => 'libvirt.conf',
      }
    }
    'Suse': {
      $package_name       = 'collectd'
      $package_provider   = 'zypper'
      $collectd_dir       = '/etc/collectd'
      $plugin_conf_dir    = $collectd_dir
      $service_name       = 'collectd'
      $config_file        = '/etc/collectd.conf'
      $config_group       = 'root'
      $java_dir           = undef
      $default_python_dir = '/usr/share/collectd/python'
      $manage_repo        = false
      $package_configs    = {}
    }
    'FreeBSD': {
      $package_name       = 'collectd5'
      $package_provider   = undef
      $collectd_dir       = '/usr/local/etc/collectd'
      $plugin_conf_dir    = $collectd_dir
      $service_name       = 'collectd'
      $config_file        = '/usr/local/etc/collectd.conf'
      $config_group       = 'wheel'
      $java_dir           = undef
      $default_python_dir = '/usr/local/share/collectd/python'
      $manage_repo        = false
      $package_configs    = {}
    }
    'OpenBSD': {
      $package_name       = 'collectd'
      $package_provider   = undef
      $collectd_dir       = '/etc/collectd'
      $plugin_conf_dir    = $collectd_dir
      $service_name       = 'collectd'
      $config_file        = '/etc/collectd.conf'
      $config_group       = '_collectd'
      $java_dir           = undef
      $default_python_dir = '/usr/local/share/collectd/python'
      $manage_repo        = false
      $package_configs    = {}
    }
    'Archlinux': {
      $package_name       = 'collectd'
      $package_provider   = undef
      $collectd_dir       = '/etc/collectd.d'
      $plugin_conf_dir    = $collectd_dir
      $service_name       = 'collectd'
      $config_file        = '/etc/collectd.conf'
      $config_group       = 'wheel'
      $java_dir           = undef
      $default_python_dir = '/usr/share/collectd/python'
      $manage_repo        = false
      $package_configs    = {}
    }
    'Gentoo': {
      $package_name       = 'app-admin/collectd'
      $package_provider   = 'portage'
      $collectd_dir       = '/etc/collectd.d'
      $plugin_conf_dir    = $collectd_dir
      $service_name       = 'collectd'
      $config_file        = '/etc/collectd.conf'
      $config_group       = 'collectd'
      $java_dir           = undef
      $default_python_dir = '/usr/share/collectd/python'
      $manage_repo        = false
      $package_configs    = {}
    }

    default: {
      fail("${facts['os']['family']} is not supported.")
    }
  }

  # Override with custom fact value (present only if python is installed)
  $python_dir = pick($facts['python_dir'], $default_python_dir)
}
