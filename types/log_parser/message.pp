#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOG_PARSER::Message = Struct[{
  'defaultplugininstance' => String,
  'defaulttype' => String,
  'defaulttypeinstance' => String,
  'defaultseverity' => String,
  'match' => Array[Hash[String[1],Collectd::LOG_PARSER::Match]]
}]
