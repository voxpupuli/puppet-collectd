#
type Collectd::SNMP::Data = Struct[{Optional['instance'] => String, NotUndef['type'] => String[1], NotUndef['values'] => Variant[String[1], Array[String[1], 1]], Optional['instance_prefix'] => String[1], Optional['scale'] => Numeric, Optional['shift'] => Numeric, Optional['table'] => Boolean, Optional['ignore'] => Variant[String[1], Array[String[1], 1]], Optional['invert_match'] => Boolean}]
