type Collectd::Threshold::Plugin = Struct[{
  name     => String[1],
  instance => Optional[String[1]],
  types    => Array[Collectd::Threshold::Type],
}]
