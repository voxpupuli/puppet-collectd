#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOG_PARSER::Match = Struct[{
  'regex' => String,
  Optional['submatchidx'] => Integer,
  Optional['excluderegex'] => String,
  Optional['ismandatory'] => Variant[Boolean, String],
  Optional['severity'] => String,
  Optional['plugininstance'] => Variant[Boolean, String],
  Optional['type'] => Variant[Boolean, String],
  Optional['typeinstance'] => Variant[Boolean, String],
}]
