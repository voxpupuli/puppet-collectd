#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOG_PARSER::Logfile = Struct[{
  'firstfullread' => Boolean,
  'message' => Array[Hash[String[1],Collectd::LOG_PARSER::Message]]
}]
