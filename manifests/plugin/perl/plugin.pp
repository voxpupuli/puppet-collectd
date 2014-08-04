#
define collectd::plugin::perl::plugin (
  $module,
  $enable_debugger = false,
  $include_dir = false,
  $provider = false,
  $source = false,
  $destination = false,
  $order = '01',
  $config = {},
) {
  include collectd::params
  if ! defined(Class['Collectd::Plugin::Perl']) {
    include collectd::plugin::perl
  }

  validate_hash($config)
  validate_re($order, '\d+')
  if $enable_debugger {
    validate_string($enable_debugger)
  }
  if $include_dir {
    if is_string($include_dir) {
      $include_dirs = [ $include_dir ]
    } elsif is_array($include_dir) {
      $include_dirs = $include_dir
    } else {
      fail("include_dir must be either array or string: ${include_dir}")
    }
  } else {
    $include_dirs = []
  }

  $conf_dir = $collectd::params::plugin_conf_dir
  $base_filename = $collectd::plugin::perl::filename
  $filename = "${conf_dir}/perl/plugin-${order}_${name}.conf"

  file { $filename:
    owner   => $collectd::params::root_user,
    group   => $collectd::params::root_group,
    mode    => '0644',
    content => template('collectd/plugin/perl/plugin.erb'),
  }

  case $provider {
    'package': {
      validate_string($source)
      package { $source:
        require => Collectd::Plugin['perl'],
      }
    }
    'cpan': {
      validate_string($source)
      include cpan
      cpan { $source:
        require => Collectd::Plugin['perl'],
      }
    }
    'file': {
      validate_string($source)
      validate_string($destination)
      file { "collectd_plugin_perl_${name}.pm":
        path    => "${destination}/${module}.pm",
        mode    => '0644',
        source  => $source,
        require => Collectd::Plugin['perl'],
      }
    }
    false: {
      # this will fail if perl collectd plugin module is not installed
      exec { "perl -M${module} -e 1": path => $::path }
    }
    default: {
      fail("Unsupported provider: ${provider}. Use 'package', 'cpan',
        'file' or false.")
    }
  }
}
