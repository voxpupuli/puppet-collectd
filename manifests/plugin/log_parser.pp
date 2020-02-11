#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
class collectd::plugin::log_parser (
  $ensure         = 'present',
  Array[Collectd::LOG_PARSER::Logfile] $logfile = []
){
include collectd

  collectd::plugin { 'log_parser':
    ensure  => $ensure,
    content => epp('collectd/plugin/log_parser.conf.epp', {
      'logfile' => $logfile,
    }),
    order   => '06',
  }
}
