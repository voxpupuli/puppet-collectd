#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOG_PARSER::Logfile = Struct[{
  'firstfullread' => Boolean,
  Array['message'] => Collectd::LOG_PARSER::Message
}]
