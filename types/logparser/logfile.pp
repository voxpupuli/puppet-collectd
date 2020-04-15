#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOGPARSER::Logfile = Struct[{
  'firstfullread' => Boolean,
  'message' => Array[Hash[String[1],Collectd::LOGPARSER::Message]]
}]
