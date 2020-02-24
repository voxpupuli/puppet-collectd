# https://wiki.opnfv.org/display/fastpath/SNMP+Agent+HLD
type Collectd::SNMP_AGENT::IndexKey = Struct[
  'source' => String,
  Optional['regex'] => String,
  Optional['group'] => String,
]
