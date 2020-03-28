#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOG_PARSER::Message = Struct[{
  Optional['defaultplugininstance'] => String,
  Optional['defaulttype'] => String,
  Optional['defaulttypeinstance'] => String,
  Optional['defaultseverity'] => String,
  Optional['match'] => Array[Hash[String[1],Collectd::LOG_PARSER::Match]]
}]
