# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_tail_csv
type Collectd::Tail_Csv::Metric = Struct[{
  'type'       => String[1],
  'value_from' => Integer[0],
  'instance'   => Optional[String[1]],
}]
