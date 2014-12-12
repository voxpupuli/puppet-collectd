# MySQL plugin
# https://collectd.org/wiki/index.php/Plugin:MySQL
class collectd::plugin::mysql (
  $interval = undef,
){
  collectd::plugin { 'mysql':
    interval => $interval,
  }
}
