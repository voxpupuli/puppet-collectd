type Collectd::Threshold::Host = Struct[{
  name    => String[1],
  plugins => Optional[Array[Collectd::Threshold::Plugin]],
  types   => Optional[Array[Collectd::Threshold::Type]],
}]
