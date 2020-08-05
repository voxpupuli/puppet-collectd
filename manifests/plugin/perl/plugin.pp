#
define collectd::plugin::perl::plugin (
  $module,
  $manage_package                              = true,
  Variant[Boolean, String] $enable_debugger    = false,
  Variant[Boolean, String, Array] $include_dir = false,
  $provider                                    = false,
  Variant[Boolean, String] $source             = false,
  Variant[Boolean, String] $destination        = false,
  String $order                                = '01',
  Hash $config                                 = {},
) {
  include collectd

  if ! defined(Class['Collectd::Plugin::Perl']) {
    include collectd::plugin::perl
  }

  if $include_dir {
    if $include_dir =~ String {
      $include_dirs = [$include_dir]
    } elsif $include_dir =~ Array {
      $include_dirs = $include_dir
    } else {
      fail("include_dir must be either array or string: ${include_dir}")
    }
  } else {
    $include_dirs = []
  }

  $conf_dir = $collectd::plugin_conf_dir
  $filename = "${conf_dir}/perl/plugin-${order}_${name}.conf"

  file { $filename:
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => template('collectd/plugin/perl/plugin.erb'),
  }

  case $provider {
    'package': {
      $_manage_package = pick($manage_package, $collectd::manage_package)
      if $_manage_package {
        package { $source:
          require => Collectd::Plugin['perl'],
        }
      }
    }
    'cpan': {
      include cpan
      cpan { $source:
        require => Collectd::Plugin['perl'],
      }
    }
    'file': {
      file { "collectd_plugin_perl_${name}.pm":
        path    => "${destination}/${module}.pm",
        mode    => '0644',
        source  => $source,
        require => Collectd::Plugin['perl'],
      }
    }
    false: {
      # this will fail if perl collectd plugin module is not installed
      $include_dirs_prefixed = prefix($include_dirs, '-I')
      $include_dirs_prefixed_joined = join($include_dirs_prefixed,' ')
      exec { "perl ${include_dirs_prefixed_joined} -e 'my\$m=shift;eval\"use \$m\";exit!exists\$INC{\$m=~s!::!/!gr.\".pm\"}' ${module}":
        path => $facts['path'],
      }
    }
    default: {
      fail("Unsupported provider: ${provider}. Use 'package', 'cpan', 'file' or false.")
    }
  }
}
