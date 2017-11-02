#
type Collectd::SNMP::Host::V2 = Struct[{NotUndef['address'] => String[1], NotUndef['version'] => Collectd::SNMP::Version::V2, NotUndef['community'] => String[1], NotUndef['collect'] => Variant[String[1], Array[String[1], 1]], Optional['interval'] => Integer[0]}]
