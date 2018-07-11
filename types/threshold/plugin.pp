type Collectd::Threshold::Plugin = Struct[{
  instance => Optional[String[1]],
  types    => Hash[String[1], Collectd::Threshold::Type],
}]
