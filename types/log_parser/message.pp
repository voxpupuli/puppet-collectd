#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOG_PARSER::Message = Struct[{
  'defaultplugininstance' => 'plugin instance',
  'defaulttype' => 'type',
  'defaulttypeinstance' => 'type instance',
  'defaultseverity' => 'ok',
  Array['match'] => [Collectd::LOG_PARSER::Match]
}]
