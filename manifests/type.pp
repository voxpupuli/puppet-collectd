define collectd::type (
  String                                                      $target,
  String                                                      $ds = $name,
  # BC compatible ....
  Optional[Enum['ABSOLUTE', 'COUNTER', 'DERIVE', 'GAUGE']]    $ds_type = undef,
  Variant[Numeric, Enum['U']]                                 $min = 'U',
  Variant[Numeric, Enum['U']]                                 $max = 'U',
  String                                                      $ds_name = 'value',
  # BC compatible .... ending

  Array[Struct[{
        min     => Variant[Numeric, Enum['U']],
        max     => Variant[Numeric, Enum['U']],
        ds_type => Enum['ABSOLUTE', 'COUNTER', 'DERIVE', 'GAUGE'],
        ds_name => String,
  }]]                                                         $types = [],
) {
  if empty($types) {
    $_types = [{
        min     => $min,
        max     => $max,
        ds_type => $ds_type,
        ds_name => $ds_name,
    }]
  } else {
    $_types = $types
  }

  $content = $_types.map |$type| { "${type['ds_name']}:${type['ds_type']}:${type['min']}:${type['max']}" }.join(', ')

  concat::fragment { "${target}/${ds}":
    content => "${ds}\t${content}",
    target  => $target,
    order   => $ds,
  }
}
