type Collectd::Threshold::Host = Struct[{
  plugins => Hash[String[1], Collectd::Threshold::Plugin],
  types   => Hash[String[1], Collectd::Threshold::Type],
}]
