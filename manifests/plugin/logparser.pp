#https://wiki.opnfv.org/display/fastpath/Logparser+plugin+HLD
class collectd::plugin::logparser (
  $ensure         = 'present',
  Array[Hash[String[1],Collectd::LOGPARSER::Logfile]] $logfile = [{
      '/var/log/syslog' => {
        'firstfullread' => false,
        'message' => [
          'pcie_errors' => {
            'defaulttype' => 'pcie_error',
            'defaultseverity' => 'warning',
            'match' => [{
                'aer error' => {
                  'regex' => 'AER:.*error received',
                  'submatchidx' => -1,
                },
                'incident time' => {
                  'regex' => '(... .. ..:..:..) .* pcieport.*AER',
                  'submatchidx' => 1,
                  'ismandatory' => false,
                },
                'root port' => {
                  'regex' => 'pcieport (.*): AER:',
                  'submatchidx' => 1,
                  'ismandatory' => true,
                },
                'device' => {
                  'plugininstance' => true,
                  'regex' => ' ([0-9a-fA-F:\\.]*): PCIe Bus Error',
                  'submatchidx' => 1,
                  'ismandatory' => false,
                },
                'severity_mandatory' => {
                  'regex' => 'severity=',
                  'submatchidx' => -1,
                },
                'nonfatal' => {
                  'regex' => 'severity=.*\\([nN]on-[fF]atal',
                  'typeinstance' => 'non_fatal',
                  'ismandatory' => false,
                },
                'fatal' => {
                  'regex' => 'severity=.*\\([fF]atal',
                  'severity' => 'failure',
                  'typeinstance' => 'fatal',
                  'ismandatory' => false,
                },
                'corrected' => {
                  'regex' => 'severity=Corrected',
                  'typeinstance' => 'correctable',
                  'ismandatory' => false,
                },
                'error type' => {
                  'regex' => 'type=(.*),',
                  'submatchidx' => 1,
                  'ismandatory' => false,
                },
                'id' => {
                  'regex' => ', id=(.*)',
                  'submatchidx' => 1,
                },
            }],
          },
        ],
      }
  }]
) {
  include collectd

  collectd::plugin { 'logparser':
    ensure  => $ensure,
    content => epp('collectd/plugin/logparser.conf.epp', {
        'logfile' => $logfile,
    }),
    order   => '06',
  }
}
