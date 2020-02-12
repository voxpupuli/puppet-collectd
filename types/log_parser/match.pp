#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
type Collectd::LOG_PARSER::Match = Struct[{
  'regex' => String,
  Optional['submatchidx'] => String,
  Optional['excluderegex'] => String,
  Optional['ismandatory'] => Boolean,
  Optional['severity'] => String,
  Optional['plugininstance'] => String,
  Optional['type'] => String,
  Optional['typeinstance'] => String
}]
