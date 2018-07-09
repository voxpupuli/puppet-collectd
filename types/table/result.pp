# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_table
type Collectd::Table::Result = Struct[{
  'type'            => String,
  'values_from'     => Array[Integer, 1],
  'instance_prefix' => Optional[String],
  'instances_from'  => Optional[Array[Integer, 1]]
}]
