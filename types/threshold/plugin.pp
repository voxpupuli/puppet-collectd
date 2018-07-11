type Collectd::Threshold::Plugin = Struct[{
  instance => Optional[String],
  types    => Hash[String, Collectd::Threshold::Type],
}]
