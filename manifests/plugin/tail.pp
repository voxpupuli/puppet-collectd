# Tail plugin
# https://collectd.org/wiki/index.php/Plugin:Tail
class collectd::plugin::tail (
  $interval             = undef,
  Optional[Hash] $files = {},
) {
  collectd::plugin { 'tail':
    interval => $interval,
  }

  $defaults = {}

  $files.each |String $resource, Hash $attributes| {
    collectd::plugin::tail::file { $resource:
      * => $defaults + $attributes,
    }
  }
}
