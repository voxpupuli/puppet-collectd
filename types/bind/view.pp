# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_bind
type Collectd::Bind::View = Struct[{
  name          => String,
  qtypes        => Optional[Boolean],
  resolverstats => Optional[Boolean],
  cacherrsets   => Optional[Boolean],
  zones         => Optional[Array[String]],
}]
