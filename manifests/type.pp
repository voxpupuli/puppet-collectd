define collectd::type (
  $target,
  $ds = $title,
  $ds_type = undef,
  $types = [],
  $min = 'U',
  $max = 'U',
  $ds_name = 'value',
) {
  validate_string($ds_name)
  validate_array($types)

  if empty($types) {
    validate_string($ds_type)

    $upper_ds_type = upcase($ds_type)

    validate_re($upper_ds_type,
      ['^ABSOLUTE$', '^COUNTER$', '^DERIVE$', '^GAUGE$'])

    if $min != 'U' {
      validate_numeric($min)
    }

    if $max != 'U' {
      validate_numeric($max)
    }

    $_types = [{
      min     => $min,
      max     => $max,
      ds_type => $upper_ds_type,
      ds_name => $ds_name,
    }]
  } else {
    # validation should be done with puppet4 types..
    $_types = $types
  }

  $content = inline_template("<%= @ds %>\t<%= @_types.map{ |type| type['ds_name']+':'+type['ds_type']+':'+type['min'].to_s+':'+type['max'].to_s }.join(', ') -%>")

  concat::fragment { "${target}/${ds}":
    content => $content,
    target  => $target,
    order   => $ds,
  }
}
