# https://wiki.opnfv.org/display/fastpath/SNMP+Agent+HLD
type Collectd::SNMP_AGENT::Data = Struct[{
  'plugin' => String,
  'oids' => String,
  Optional['type'] => String,
  Optional['typeinstance'] => String,
  Optional['scale'] => String,
  Optional['shift'] => String,
  Optional['indexkey'] => Collectd::SNMP_AGENT::IndexKey,
  Optional['plugininstance'] => String,
}]
