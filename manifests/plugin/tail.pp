# Tail plugin
# https://collectd.org/wiki/index.php/Plugin:Tail
class collectd::plugin::tail (
  $interval = undef,
  $files = undef,
) {

  if $files { validate_hash($files) }

  collectd::plugin { 'tail':
    interval => $interval,
  }

  if $files {
    create_resources(collectd::plugin::tail::file, $files)
  }
}
