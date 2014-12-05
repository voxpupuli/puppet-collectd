# Tail plugin
# https://collectd.org/wiki/index.php/Plugin:Tail
class collectd::plugin::tail (
  $interval = undef,
){
  collectd::plugin { 'tail':
    interval => $interval,
  }
}

