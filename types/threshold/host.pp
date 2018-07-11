type Collectd::Threshold::Host = Struct[{
  plugins => Hash[String, Collectd::Threshold::Plugin],
  types   => Hash[String, Collectd::Threshold::Type],
}]
