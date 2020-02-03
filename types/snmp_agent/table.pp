# https://wiki.opnfv.org/display/fastpath/SNMP+Agent+HLD
type Collectd::SNMP_AGENT::Table = Struct[{
  Optional['indexoid'] => String,
  Optional['sizeoid'] => String,
  Optional['data'] => Hash[String[1], Collectd::SNMP_AGENT::Data]
}]
