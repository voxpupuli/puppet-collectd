function collectd::indent(String $arg) >> String {
  $body = regsubst($arg,  "\n(.)", "\n  \\1", 'G')
  "  ${body}"
}
