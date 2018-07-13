type Collectd::Threshold::Host = Struct[{
  name    => String[1],
  plugins => Array[Collectd::Threshold::Plugin],
  types   => Array[Collectd::Threshold::Type],
}]
