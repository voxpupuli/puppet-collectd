# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_mcelog
class collectd::plugin::mcelog (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[Boolean] $manage_package = undef,
  Optional[Array] $package_install_options = $collectd::package_install_options,
  # Log file option and memory option are mutualy exclusive.
  Optional[String] $mceloglogfile = undef,
  Optional[Collectd::MCELOG::Memory] $memory = {
    'mcelogclientsocket' => '/var/run/mcelog-client',
    'persistentnotification' => false,
  }
) {
  include collectd

  $_manage_package = pick($manage_package, $collectd::manage_package)

  if $ensure == 'present' {
    $package_ensure = $collectd::package_ensure
  } elsif $ensure == 'absent' {
    $package_ensure = 'absent'
  }

  if $facts['os']['family'] == 'RedHat' {
    if $_manage_package {
      package { 'collectd-mcelog':
        ensure          => $package_ensure,
        install_options => $package_install_options,
      }
    }
  }

  collectd::plugin { 'mcelog':
    ensure  => $ensure,
    content => epp('collectd/plugin/mcelog.conf.epp', {
        'mceloglogfile' => $mceloglogfile,
        'memory'        => $memory
    }),
  }
}
