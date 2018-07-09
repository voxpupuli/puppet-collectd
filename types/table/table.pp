# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_table
type Collectd::Table::Table = Struct[{
  'plugin'    => Optional[String],
  'separator' => Optional[String],
  'instance'  => Optional[String],
  'results'   => Array[Collectd::Table::Result, 1]
}]
