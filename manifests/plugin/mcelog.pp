# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_mcelog
class collectd::plugin::mcelog (
  Enum['present', 'absent'] $ensure = 'present',
  # Log file option and memory option are mutualy exclusive.
  Optional[String] $mceloglogfile = undef,
  Optional[Collectd::MCELOG::Memory] $memory = {
    'mcelogclientsocket' => '/var/run/mcelog-client',
    'persistentnotification' => false,
  }
) {

  include collectd

  collectd::plugin { 'mcelog':
    ensure  => $ensure,
    content => epp('collectd/plugin/mcelog.conf.epp', {
        'mceloglogfile' => $mceloglogfile,
        'memory'        => $memory
    }),
  }
}
