# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_tail_csv
type Collectd::Tail_Csv::File = Struct[{
  'collect'   => Array[String, 1],
  'plugin'    => Optional[String[1]],
  'instance'  => Optional[String[1]],
  'interval'  => Optional[Numeric],
  'time_from' => Optional[Integer[0]],
}]
