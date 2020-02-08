# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_mcelog
type Collectd::MCELOG::Memory = Struct[{
  NotUndef['mcelogclientsocket'] => String[1],
  NotUndef['persistentnotification'] => Boolean,
}]
