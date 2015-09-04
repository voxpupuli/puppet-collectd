define collectd::type (
  $target,
  $ds_type,
  $ds = $title,
  $min = 'U',
  $max = 'U',
  $ds_name = 'value',
) {
  validate_string($ds_name)
  $upper_ds_type = upcase($ds_type)

  validate_re($upper_ds_type,
              ['^ABSOLUTE$', '^COUNTER$', '^DERIVE$', '^GAUGE$'])

  if $min != 'U' {
    validate_numeric($min)
  }

  if $max != 'U' {
    validate_numeric($max)
  }

  $content = "${ds}\t${ds_name}:${upper_ds_type}:${min}:${max}"

  concat::fragment { "${target}/${ds}":
    content => $content,
    target  => $target,
    order   => $ds,
  }
}
